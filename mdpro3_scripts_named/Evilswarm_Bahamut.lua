--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 入魔龙王 巴哈姆特  (ID: 36757171)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Dragon
-- Rank 4
-- ATK 2350 | DEF 1350
-- Setcode: 10
--
-- Effect Text:
-- 名字带有「入魔」的4星怪兽×2
-- 1回合1次，把这张卡1个超量素材取除，选择对方场上表侧表示存在的1只怪兽才能发动。从手卡丢弃1只名字带有「入魔」的怪兽，得到选择的对方怪兽的控制权。
--[[ __CARD_HEADER_END__ ]]

--ヴェルズ・バハムート
function c36757171.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0xa),4,2)
	c:EnableReviveLimit()
	--attack up
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL+CATEGORY_HANDES)
	e1:SetDescription(aux.Stringid(36757171,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c36757171.cost)
	e1:SetTarget(c36757171.target)
	e1:SetOperation(c36757171.operation)
	c:RegisterEffect(e1)
end
function c36757171.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c36757171.filter(c)
	return c:IsFaceup() and c:IsControlerCanBeChanged()
end
function c36757171.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c36757171.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c36757171.filter,tp,0,LOCATION_MZONE,1,nil)
		and Duel.IsExistingMatchingCard(c36757171.dfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c36757171.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,tp,1)
end
function c36757171.dfilter(c)
	return c:IsSetCard(0xa) and c:IsType(TYPE_MONSTER) and c:IsDiscardable()
end
function c36757171.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local g=Duel.SelectMatchingCard(tp,c36757171.dfilter,tp,LOCATION_HAND,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.SendtoGrave(g,REASON_EFFECT+REASON_DISCARD)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.GetControl(tc,tp)
	end
end
