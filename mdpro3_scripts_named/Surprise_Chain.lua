--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 惊心供应链  (ID: 70491413)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：同一连锁上没有复数次同名卡的效果发动的场合，那个连锁2以后才能发动。这张卡的发动时积累的连锁数量的以下效果适用。
-- ●2个以上：把这张卡的发动时积累的连锁数量的卡从自己卡组上面翻开，用喜欢的顺序回到卡组上面。
-- ●3个以上：从自己卡组上面把1张卡送去墓地。
-- ●4个以上：自己从卡组抽1张。
--[[ __CARD_HEADER_END__ ]]

--サプライズ・チェーン
function c70491413.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,70491413+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c70491413.condition)
	e1:SetTarget(c70491413.target)
	e1:SetOperation(c70491413.activate)
	c:RegisterEffect(e1)
end
function c70491413.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentChain()>0 and Duel.CheckChainUniqueness()
end
function c70491413.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local cl=Duel.GetCurrentChain()
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=cl
		and (cl<3 or Duel.IsPlayerCanDiscardDeck(tp,1))
		and (cl<4 or Duel.IsPlayerCanDraw(tp,1))
	end
	local cat=0
	if cl>=3 then
		cat=cat|CATEGORY_TOGRAVE
		Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
	end
	if cl>=4 then
		cat=cat|CATEGORY_DRAW
		Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
	end
	e:SetCategory(cat)
end
function c70491413.activate(e,tp,eg,ep,ev,re,r,rp)
	local cl=Duel.GetCurrentChain()
	if cl>=2 then
		Duel.ConfirmDecktop(tp,cl)
		local g=Duel.GetDecktopGroup(tp,cl)
		if g:GetCount()>0 then
			Duel.SortDecktop(tp,tp,g:GetCount())
		end
	end
	if cl>=3 then
		Duel.BreakEffect()
		Duel.DiscardDeck(tp,1,REASON_EFFECT)
	end
	if cl>=4 then
		Duel.BreakEffect()
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
