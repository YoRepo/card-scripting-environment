--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Ghostrick Warwolf  (ID: 72913666)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Zombie
-- Level: 3
-- ATK 1400 | DEF 1500
-- Setcode: 0x8d
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be Normal Summoned, unless you control a "Ghostrick" monster.
-- Once per turn: You can change this card to face-down Defense Position.
-- When this card is flipped face-up: Inflict 100 damage to your opponent for each Set card on the
-- field.
-- You can only use this effect of "Ghostrick Warwolf" once per turn.
--[[ __CARD_HEADER_END__ ]]

--ゴーストリック・ワーウルフ
function c72913666.initial_effect(c)
	--summon limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetCondition(c72913666.sumcon)
	c:RegisterEffect(e1)
	--turn set
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(72913666,0))
	e2:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c72913666.postg)
	e2:SetOperation(c72913666.posop)
	c:RegisterEffect(e2)
	--damage
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(72913666,1))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetCode(EVENT_FLIP)
	e3:SetCountLimit(1,72913666)
	e3:SetTarget(c72913666.damtg)
	e3:SetOperation(c72913666.damop)
	c:RegisterEffect(e3)
end
function c72913666.sfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x8d)
end
function c72913666.sumcon(e)
	return not Duel.IsExistingMatchingCard(c72913666.sfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c72913666.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsCanTurnSet() and c:GetFlagEffect(72913666)==0 end
	c:RegisterFlagEffect(72913666,RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET+RESET_PHASE+PHASE_END,0,1)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,c,1,0,0)
end
function c72913666.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.ChangePosition(c,POS_FACEDOWN_DEFENSE)
	end
end
function c72913666.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ct=Duel.GetMatchingGroupCount(Card.IsFacedown,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(ct*100)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,0,0,1-tp,ct*100)
end
function c72913666.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local ct=Duel.GetMatchingGroupCount(Card.IsFacedown,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.Damage(p,ct*100,REASON_EFFECT)
end
