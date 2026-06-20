--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 星风狼 沃尔夫拉叶狼  (ID: 3322931)
-- Type: Monster / Effect / Synchro
-- Attribute: WIND
-- Race: Beast
-- Level 9
-- ATK 2500 | DEF 0
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- ①：「星风狼 沃尔夫拉叶狼」在自己场上只能有1只表侧表示存在。
-- ②：只要攻击力未满4000的这张卡在怪兽区域存在，每次这张卡以外的怪兽的效果发动，这张卡的攻击力上升300。
-- ③：1回合1次，这张卡的攻击力是4000以上的场合才能发动。这张卡和对方场上的怪兽全部回到持有者卡组。这个效果在对方回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--星風狼ウォルフライエ
function c3322931.initial_effect(c)
	c:SetUniqueOnField(1,0,3322931)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--attack up
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(aux.chainreg)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVED)
	e2:SetRange(LOCATION_MZONE)
	e2:SetOperation(c3322931.atkop)
	c:RegisterEffect(e2)
	--to deck
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(3322931,0))
	e3:SetCategory(CATEGORY_TODECK)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e3:SetCountLimit(1)
	e3:SetCondition(c3322931.tdcon)
	e3:SetTarget(c3322931.tdtg)
	e3:SetOperation(c3322931.tdop)
	c:RegisterEffect(e3)
end
function c3322931.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetAttack()<4000 and re:GetHandler()~=c and re:IsActiveType(TYPE_MONSTER) and c:GetFlagEffect(FLAG_ID_CHAINING)>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(300)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
function c3322931.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsAttackAbove(4000)
end
function c3322931.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,0,LOCATION_MZONE,nil)
	if chk==0 then return c:IsAbleToDeck() and g:GetCount()>0 end
	g:AddCard(c)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c3322931.tdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local g=Duel.GetMatchingGroup(nil,tp,0,LOCATION_MZONE,nil)
		if g:GetCount()>0 then
			g:AddCard(c)
			Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
		end
	end
end
