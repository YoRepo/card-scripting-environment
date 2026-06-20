--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 武神器-丛云  (ID: 69723159)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Beast
-- Level 4
-- ATK 1600 | DEF 900
-- Setcode: 136
--
-- Effect Text:
-- 自己的主要阶段时，自己场上有名字带有「武神」的兽战士族怪兽存在的场合，把墓地的这张卡从游戏中除外才能发动。选择对方场上表侧表示存在的1张卡破坏。「武神器-丛云」的效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--武神器－ムラクモ
function c69723159.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(69723159,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,69723159)
	e1:SetCondition(c69723159.descon)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(c69723159.destg)
	e1:SetOperation(c69723159.desop)
	c:RegisterEffect(e1)
end
function c69723159.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x88) and c:IsRace(RACE_BEASTWARRIOR)
end
function c69723159.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c69723159.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c69723159.filter(c)
	return c:IsFaceup()
end
function c69723159.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c69723159.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c69723159.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c69723159.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c69723159.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
