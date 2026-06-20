--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 发条猎人  (ID: 16923472)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Beast-Warrior
-- Level 3
-- ATK 1600 | DEF 500
-- Setcode: 88
--
-- Effect Text:
-- 自己的主要阶段时，把「发条猎人」以外的自己场上表侧表示存在的1只名字带有「发条」的怪兽解放才能发动。对方手卡随机1张送去墓地。这个效果只在这张卡在场上表侧表示存在能使用1次。
--[[ __CARD_HEADER_END__ ]]

--ゼンマイハンター
function c16923472.initial_effect(c)
	--handes
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(16923472,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_NO_TURN_RESET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c16923472.cost)
	e1:SetTarget(c16923472.target)
	e1:SetOperation(c16923472.operation)
	c:RegisterEffect(e1)
end
function c16923472.costfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x58) and not c:IsCode(16923472)
end
function c16923472.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c16923472.costfilter,1,nil) end
	local sg=Duel.SelectReleaseGroup(tp,c16923472.costfilter,1,1,nil)
	Duel.Release(sg,REASON_COST)
end
function c16923472.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(1-tp,LOCATION_HAND,0)~=0 end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,1-tp,LOCATION_HAND)
end
function c16923472.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(1-tp,LOCATION_HAND,0)
	if g:GetCount()==0 then return end
	local sg=g:RandomSelect(1-tp,1)
	Duel.SendtoGrave(sg,REASON_EFFECT)
end
