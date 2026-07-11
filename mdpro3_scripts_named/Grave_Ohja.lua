--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Grave Ohja  (ID: 40937767)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level: 4
-- ATK 1600 | DEF 1500
-- Scope: OCG / TCG
--
-- Effect Text:
-- While there is a face-down Defense Position monster(s) on your side of the field, no player can
-- select this card as an attack target.
-- Each time a monster on your side of the field is Flip Summoned, inflict 300 damage to your opponent.
--[[ __CARD_HEADER_END__ ]]

--グレイヴ・オージャ
function c40937767.initial_effect(c)
	--cannot be battle target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetCondition(c40937767.ccon)
	e1:SetValue(aux.imval1)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(40937767,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	e2:SetCondition(c40937767.damcon)
	e2:SetTarget(c40937767.damtg)
	e2:SetOperation(c40937767.damop)
	c:RegisterEffect(e2)
end
function c40937767.ccon(e)
	return Duel.IsExistingMatchingCard(Card.IsPosition,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil,POS_FACEDOWN_DEFENSE)
end
function c40937767.damcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and eg:GetFirst()~=e:GetHandler()
end
function c40937767.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(300)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,300)
end
function c40937767.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
