--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 娱乐伙伴表演尾声  (ID: 92958307)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 159
--
-- Effect Text:
-- ①：以最多有自己场上的表侧表示的魔法卡数量的对方场上的表侧表示怪兽为对象才能发动。那些怪兽变成里侧守备表示。
--[[ __CARD_HEADER_END__ ]]

--EMショーダウン
function c92958307.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetHintTiming(TIMING_BATTLE_PHASE,TIMINGS_CHECK_MONSTER+TIMING_BATTLE_PHASE)
	e1:SetTarget(c92958307.target)
	e1:SetOperation(c92958307.activate)
	c:RegisterEffect(e1)
end
function c92958307.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_SPELL)
end
function c92958307.filter(c)
	return c:IsFaceup() and c:IsCanTurnSet()
end
function c92958307.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local sc=Duel.GetMatchingGroupCount(c92958307.cfilter,tp,LOCATION_ONFIELD,0,nil)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c92958307.filter(chkc) end
	if chk==0 then return sc>0 and Duel.IsExistingTarget(c92958307.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c92958307.filter,tp,0,LOCATION_MZONE,1,sc,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c92958307.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()>0 then
		Duel.ChangePosition(g,POS_FACEDOWN_DEFENSE)
	end
end
