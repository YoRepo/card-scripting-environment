--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 自奏圣乐·朗吉尔苏  (ID: 76145142)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Machine
-- ATK 2500 | LINK
-- Setcode: 283
--
-- Effect Text:
-- 包含「自奏圣乐」怪兽的效果怪兽2只以上
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：连接状态的这张卡不会被效果破坏。
-- ②：以自己的除外状态的2只机械族怪兽为对象才能发动（这个效果发动的回合，这张卡不能攻击）。那些怪兽回到卡组。那之后，可以把1只连接状态的对方怪兽送去墓地。
--[[ __CARD_HEADER_END__ ]]

--オルフェゴール・ロンギルス
function c76145142.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkType,TYPE_EFFECT),2,99,c76145142.lcheck)
	c:EnableReviveLimit()
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetCondition(c76145142.indcon)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--todeck
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(76145142,0))
	e2:SetCategory(CATEGORY_TODECK+CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,76145142)
	e2:SetCondition(c76145142.tdcon1)
	e2:SetCost(c76145142.tdcost)
	e2:SetTarget(c76145142.tdtg)
	e2:SetOperation(c76145142.tdop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	e3:SetCondition(c76145142.tdcon2)
	c:RegisterEffect(e3)
end
function c76145142.lcheck(g)
	return g:IsExists(Card.IsLinkSetCard,1,nil,0x11b)
end
function c76145142.indcon(e)
	return e:GetHandler():IsLinkState()
end
function c76145142.tdcon1(e,tp,eg,ep,ev,re,r,rp)
	return not aux.IsCanBeQuickEffect(e:GetHandler(),tp,90351981)
end
function c76145142.tdcon2(e,tp,eg,ep,ev,re,r,rp)
	return aux.IsCanBeQuickEffect(e:GetHandler(),tp,90351981)
end
function c76145142.tdcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetAttackAnnouncedCount()==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e1)
end
function c76145142.tdfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_MACHINE) and c:IsAbleToDeck()
end
function c76145142.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and c76145142.tdfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c76145142.tdfilter,tp,LOCATION_REMOVED,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c76145142.tdfilter,tp,LOCATION_REMOVED,0,2,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,2,0,0)
end
function c76145142.tdop(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if tg:GetCount()>0 and Duel.SendtoDeck(tg,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)~=0 and tg:IsExists(Card.IsLocation,1,nil,LOCATION_DECK+LOCATION_EXTRA) then
		local g=Duel.GetMatchingGroup(Card.IsLinkState,tp,0,LOCATION_MZONE,nil)
		if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(76145142,1)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
			local sg=g:Select(tp,1,1,nil)
			Duel.SendtoGrave(sg,REASON_EFFECT)
		end
	end
end
