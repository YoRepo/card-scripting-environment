--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 傀儡流仪-傀儡鲨  (ID: 53323475)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 28835971
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：场上1个超量素材取除，从自己卡组上面把4张卡翻开，从那之中选1张。那张卡种类的以下效果适用。剩下的卡用原本的顺序回到卡组上面。
-- ●怪兽·魔法：选的卡加入手卡。
-- ●陷阱：选的卡在自己场上盖放。这个效果盖放的卡在盖放的回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--傀儡流儀－パペット・シャーク
local s,id,o=GetID()
function s.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_SSET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetTarget(s.thtg)
	e1:SetOperation(s.thop)
	c:RegisterEffect(e1)
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckRemoveOverlayCard(tp,1,1,1,REASON_EFFECT) and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>=4 end
end
function s.thfilter(c,tp)
	return c:IsType(TYPE_TRAP) and Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		or c:IsType(TYPE_MONSTER+TYPE_SPELL) and c:IsAbleToHand()
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.RemoveOverlayCard(tp,1,1,1,1,REASON_EFFECT)~=0 then
		Duel.ConfirmDecktop(tp,4)
		local g=Duel.GetDecktopGroup(tp,4):Filter(s.thfilter,nil,tp)
		if #g>0 then
			Duel.DisableShuffleCheck()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPERATECARD)
			Duel.RevealSelectDeckSequence(true)
			local sc=g:Select(tp,1,1,nil):GetFirst()
			Duel.RevealSelectDeckSequence(false)
			if sc:IsType(TYPE_TRAP) then
				if Duel.SSet(tp,sc)>0 then
					local e1=Effect.CreateEffect(c)
					e1:SetDescription(aux.Stringid(id,1))
					e1:SetType(EFFECT_TYPE_SINGLE)
					e1:SetCode(EFFECT_TRAP_ACT_IN_SET_TURN)
					e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
					e1:SetReset(RESET_EVENT+RESETS_STANDARD)
					sc:RegisterEffect(e1)
				end
			else
				Duel.SendtoHand(sc,nil,REASON_EFFECT)
				Duel.ConfirmCards(1-tp,sc)
				Duel.ShuffleHand(tp)
			end
		end
	end
end
