--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Blizzard Falcon  (ID: 43694481)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Winged Beast
-- Level: 4
-- ATK 1500 | DEF 1500
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card's current ATK is higher than its original ATK: You can inflict 1500 damage to your
-- opponent.
-- This effect can only be used once while this card is face-up on the field.
-- You can only use this effect of "Blizzard Falcon" once per turn.
--[[ __CARD_HEADER_END__ ]]

--ブリザード・ファルコン
function c43694481.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(43694481,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_NO_TURN_RESET)
	e1:SetCountLimit(1,43694481)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c43694481.damcon)
	e1:SetTarget(c43694481.damtg)
	e1:SetOperation(c43694481.damop)
	c:RegisterEffect(e1)
end
function c43694481.damcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetAttack()>e:GetHandler():GetBaseAttack()
end
function c43694481.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(1500)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1500)
end
function c43694481.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
