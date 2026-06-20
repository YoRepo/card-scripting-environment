--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 珀耳修斯的神域  (ID: 15449853)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 266
--
-- Effect Text:
-- ①：这张卡的卡名只要在场上·墓地存在当作「天空的圣域」使用。
-- ②：只要这张卡在魔法与陷阱区域存在，场上的天使族怪兽的攻击力·守备力上升300，场上盖放的魔法·陷阱卡不会成为效果的对象，不会被效果破坏。
-- ③：1回合1次，从自己墓地的天使族怪兽以及反击陷阱卡之中以合计3张为对象才能发动（同名卡最多1张）。那些卡用喜欢的顺序回到卡组上面。
--[[ __CARD_HEADER_END__ ]]

--パーシアスの神域
function c15449853.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--change
	aux.EnableChangeCode(c,56433456,LOCATION_SZONE+LOCATION_GRAVE)
	--atk/def
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_FAIRY))
	e3:SetValue(300)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e4)
	--cannot be target/indestructable
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e5:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e5:SetRange(LOCATION_SZONE)
	e5:SetTargetRange(LOCATION_SZONE,LOCATION_SZONE)
	e5:SetTarget(aux.TargetBoolFunction(Card.IsPosition,POS_FACEDOWN))
	e5:SetValue(1)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e6:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	c:RegisterEffect(e6)
	--to deck
	local e7=Effect.CreateEffect(c)
	e7:SetCategory(CATEGORY_TODECK)
	e7:SetType(EFFECT_TYPE_IGNITION)
	e7:SetRange(LOCATION_SZONE)
	e7:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e7:SetCountLimit(1)
	e7:SetTarget(c15449853.tdtg)
	e7:SetOperation(c15449853.tdop)
	c:RegisterEffect(e7)
end
function c15449853.tdfilter(c,e)
	return (c:IsRace(RACE_FAIRY) or c:IsType(TYPE_COUNTER)) and c:IsAbleToDeck() and (not e or c:IsCanBeEffectTarget(e))
end
function c15449853.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local g=Duel.GetMatchingGroup(c15449853.tdfilter,tp,LOCATION_GRAVE,0,nil,e)
	if chk==0 then return g:GetClassCount(Card.GetCode)>=3 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local tg=g:SelectSubGroup(tp,aux.dncheck,false,3,3)
	Duel.SetTargetCard(tg)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,tg,tg:GetCount(),0,0)
end
function c15449853.tdop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if tg:GetCount()==0 then return end
	if Duel.SendtoDeck(tg,nil,SEQ_DECKTOP,REASON_EFFECT)==0 then return end
	local ct=Duel.GetOperatedGroup():FilterCount(Card.IsLocation,nil,LOCATION_DECK)
	if ct>0 then Duel.SortDecktop(tp,tp,ct) end
end
