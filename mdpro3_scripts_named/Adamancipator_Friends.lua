--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 魔救之奇缘  (ID: 99927991)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 320
--
-- Effect Text:
-- ①：把自己场上的岩石族怪兽数量＋5张从自己卡组上面翻开。可以从那之中选持有翻开的卡数量以下的等级的1只岩石族怪兽加入手卡。剩下的卡用喜欢的顺序回到卡组最下面。这张卡的发动后，直到回合结束时自己不是岩石
-- 族怪兽不能特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--魔救の奇縁
function c99927991.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c99927991.target)
	e1:SetOperation(c99927991.activate)
	c:RegisterEffect(e1)
end
function c99927991.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_ROCK)
end
function c99927991.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c99927991.filter,tp,LOCATION_MZONE,0,nil)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>4+g:GetCount() end
end
function c99927991.thfilter(c,lv)
	return c:IsRace(RACE_ROCK) and c:IsLevelBelow(lv) and c:IsAbleToHand()
end
function c99927991.activate(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetMatchingGroup(c99927991.filter,tp,LOCATION_MZONE,0,nil)
	local count=5+tg:GetCount()
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=count then
		Duel.ConfirmDecktop(tp,count)
		local g=Duel.GetDecktopGroup(tp,count)
		local ct=g:GetCount()
		if ct>0 and g:FilterCount(c99927991.thfilter,nil,ct)>0 and Duel.SelectYesNo(tp,aux.Stringid(99927991,0)) then
			Duel.DisableShuffleCheck()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local sg=g:FilterSelect(tp,c99927991.thfilter,1,1,nil,ct)
			Duel.SendtoHand(sg,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,sg)
			Duel.ShuffleHand(tp)
			ct=g:GetCount()-sg:GetCount()
		end
		if ct>0 then
			Duel.SortDecktop(tp,tp,ct)
			for i=1,ct do
				local mg=Duel.GetDecktopGroup(tp,1)
				Duel.MoveSequence(mg:GetFirst(),SEQ_DECKBOTTOM)
			end
		end
	end
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		e1:SetTargetRange(1,0)
		e1:SetTarget(c99927991.splimit)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
	end
end
function c99927991.splimit(e,c)
	return not c:IsRace(RACE_ROCK)
end
