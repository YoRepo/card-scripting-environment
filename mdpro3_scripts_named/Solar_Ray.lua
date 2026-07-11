--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Solar Ray  (ID: 44472639)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- Inflict 600 points of damage to your opponent's Life Points for each face-up LIGHT monster on your
-- side of the field.
--[[ __CARD_HEADER_END__ ]]

--ソーラーレイ
function c44472639.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1c1)
	e1:SetTarget(c44472639.target)
	e1:SetOperation(c44472639.activate)
	c:RegisterEffect(e1)
end
function c44472639.filter(c)
	return c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsFaceup()
end
function c44472639.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44472639.filter,tp,LOCATION_MZONE,0,1,nil) end
	local dam=Duel.GetMatchingGroupCount(c44472639.filter,tp,LOCATION_MZONE,0,nil)*600
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c44472639.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local dam=Duel.GetMatchingGroupCount(c44472639.filter,tp,LOCATION_MZONE,0,nil)*600
	Duel.Damage(p,dam,REASON_EFFECT)
end
