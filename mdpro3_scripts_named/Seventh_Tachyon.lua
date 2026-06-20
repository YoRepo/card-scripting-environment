--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 时空之七皇  (ID: 7477101)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 24445364
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：把额外卡组1只「No.101」～「No.107」其中任意种的「No.」超量怪兽给对方观看才能发动。种族或属性和给人观看的怪兽相同而持有和那只怪兽的阶级相同数值的等级的1只怪兽从卡组加入手卡。那之后
-- ，选自己1张手卡回到卡组最上面。这张卡的发动后，直到回合结束时自己不是超量怪兽不能从额外卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--時空の七皇
local s,id,o=GetID()
function s.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(s.thtg)
	e1:SetOperation(s.thop)
	c:RegisterEffect(e1)
end
function s.thfilter1(c,tp)
	local no=aux.GetXyzNumber(c)
	return no and no>=101 and no<=107 and c:IsSetCard(0x48) and c:IsType(TYPE_XYZ) and not c:IsPublic()
		and Duel.IsExistingMatchingCard(s.thfilter2,tp,LOCATION_DECK,0,1,nil,c:GetAttribute(),c:GetRace(),c:GetRank())
end
function s.thfilter2(c,att,race,rk)
	return (c:IsRace(race) or c:IsAttribute(att)) and c:IsLevel(rk)
		and c:IsAbleToHand()
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.thfilter1,tp,LOCATION_EXTRA,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,s.thfilter1,tp,LOCATION_EXTRA,0,1,1,nil,tp)
	local tc=g:GetFirst()
	Duel.ConfirmCards(1-tp,tc)
	e:SetLabel(tc:GetAttribute(),tc:GetRace(),tc:GetRank())
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_HAND)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	local att,race,rk=e:GetLabel()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,s.thfilter2,tp,LOCATION_DECK,0,1,1,nil,att,race,rk)
	local tc2=g:GetFirst()
	if tc2 and Duel.SendtoHand(tc2,nil,REASON_EFFECT)~=0 and tc2:IsLocation(LOCATION_HAND) then
		Duel.ConfirmCards(1-tp,tc2)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local dg=Duel.GetFieldGroup(tp,LOCATION_HAND,0):Select(tp,1,1,nil)
		Duel.ShuffleDeck(tp)
		Duel.ShuffleHand(tp)
		if dg:GetCount()>0 then
			Duel.BreakEffect()
			Duel.SendtoDeck(dg,nil,SEQ_DECKTOP,REASON_EFFECT)
		end
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(s.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function s.splimit(e,c)
	return not c:IsType(TYPE_XYZ) and c:IsLocation(LOCATION_EXTRA)
end
