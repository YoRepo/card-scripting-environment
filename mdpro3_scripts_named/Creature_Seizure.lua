--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 虏获装置  (ID: 15305240)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 双方选择自己场上怪兽各1只，那些怪兽的控制权交换。但是这张卡的控制者必须选择自己场上表侧表示存在的通常怪兽。
--[[ __CARD_HEADER_END__ ]]

--鹵獲装置
function c15305240.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c15305240.target)
	e1:SetOperation(c15305240.activate)
	c:RegisterEffect(e1)
end
function c15305240.filter(c)
	local tp=c:GetControler()
	return c:IsFaceup() and c:IsType(TYPE_NORMAL) and c:IsAbleToChangeControler()
		and Duel.GetMZoneCount(tp,c,tp,LOCATION_REASON_CONTROL)>0
end
function c15305240.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c15305240.filter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(Card.IsAbleToChangeControler,tp,0,LOCATION_MZONE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,nil,0,0,0)
end
function c15305240.activate(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsExistingMatchingCard(c15305240.filter,tp,LOCATION_MZONE,0,1,nil)
		or not Duel.IsExistingMatchingCard(Card.IsAbleToChangeControler,tp,0,LOCATION_MZONE,1,nil)
	then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g1=Duel.SelectMatchingCard(tp,c15305240.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.HintSelection(g1)
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_CONTROL)
	local g2=Duel.SelectMatchingCard(1-tp,Card.IsAbleToChangeControler,1-tp,LOCATION_MZONE,0,1,1,nil)
	Duel.HintSelection(g2)
	local c1=g1:GetFirst()
	local c2=g2:GetFirst()
	Duel.SwapControl(c1,c2,0,0)
end
