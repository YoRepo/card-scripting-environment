--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 自奏圣乐·伽拉忒亚  (ID: 30741503)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Machine
-- ATK 1800 | LINK
-- Setcode: 283
--
-- Effect Text:
-- 包含「自奏圣乐」怪兽的效果怪兽2只
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：连接状态的这张卡不会被战斗破坏。
-- ②：以自己的除外状态的1只机械族怪兽为对象才能发动。那只怪兽回到卡组。那之后，可以从卡组把1张「自奏圣乐」魔法·陷阱卡在自己场上盖放。
--[[ __CARD_HEADER_END__ ]]

--オルフェゴール・ガラテア
function c30741503.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkType,TYPE_EFFECT),2,2,c30741503.lcheck)
	c:EnableReviveLimit()
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetCondition(c30741503.indcon)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--todeck
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(30741503,0))
	e2:SetCategory(CATEGORY_TODECK+CATEGORY_SSET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,30741503)
	e2:SetCondition(c30741503.tdcon1)
	e2:SetTarget(c30741503.tdtg)
	e2:SetOperation(c30741503.tdop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetCondition(c30741503.tdcon2)
	c:RegisterEffect(e3)
end
function c30741503.lcheck(g)
	return g:IsExists(Card.IsLinkSetCard,1,nil,0x11b)
end
function c30741503.indcon(e)
	return e:GetHandler():IsLinkState()
end
function c30741503.tdcon1(e,tp,eg,ep,ev,re,r,rp)
	return not aux.IsCanBeQuickEffect(e:GetHandler(),tp,90351981)
end
function c30741503.tdcon2(e,tp,eg,ep,ev,re,r,rp)
	return aux.IsCanBeQuickEffect(e:GetHandler(),tp,90351981)
end
function c30741503.tdfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_MACHINE) and c:IsAbleToDeck()
end
function c30741503.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and c30741503.tdfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c30741503.tdfilter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c30741503.tdfilter,tp,LOCATION_REMOVED,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c30741503.setfilter(c)
	return c:IsSetCard(0x11b) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsSSetable()
end
function c30741503.tdop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_DECK+LOCATION_EXTRA) then
		local g=Duel.GetMatchingGroup(c30741503.setfilter,tp,LOCATION_DECK,0,nil)
		if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(30741503,1)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
			local sg=g:Select(tp,1,1,nil)
			Duel.SSet(tp,sg)
		end
	end
end
