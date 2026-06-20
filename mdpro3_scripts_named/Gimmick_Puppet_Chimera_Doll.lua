--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 机关傀儡-奇美拉人偶  (ID: 97520532)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Machine
-- ATK 1500 | LINK
-- Setcode: 4227
--
-- Effect Text:
-- 机械族怪兽2只
-- 这个卡名的效果1回合只能使用1次。
-- ①：这张卡是已连接召唤的场合才能发动。从卡组选1只「机关傀儡」怪兽加入手卡或送去墓地。自己场上的怪兽只有「机关傀儡」怪兽的场合，可以再从手卡把1只「机关傀儡」怪兽特殊召唤。这个效果的发动后，直到回合结
-- 束时自己不是机械族超量怪兽不能从额外卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ギミック・パペット－キメラ・ドール
function c97520532.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkRace,RACE_MACHINE),2,2)
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(97520532,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_DECKDES+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,97520532)
	e1:SetCondition(c97520532.thcon)
	e1:SetTarget(c97520532.thtg)
	e1:SetOperation(c97520532.thop)
	c:RegisterEffect(e1)
end
function c97520532.thcon(e)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_LINK)
end
function c97520532.thfilter(c)
	return c:IsSetCard(0x1083) and c:IsType(TYPE_MONSTER) and (c:IsAbleToHand() or c:IsAbleToGrave())
end
function c97520532.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c97520532.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c97520532.cfilter(c)
	return c:IsFacedown() or not c:IsSetCard(0x1083)
end
function c97520532.spfilter(c,e,tp)
	return c:IsSetCard(0x1083) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c97520532.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPERATECARD)
	local g1=Duel.SelectMatchingCard(tp,c97520532.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g1:GetCount()>0 then
		local tc=g1:GetFirst()
		local res=false
		if tc and tc:IsAbleToHand() and (not tc:IsAbleToGrave() or Duel.SelectOption(tp,1190,1191)==0) then
			if Duel.SendtoHand(tc,nil,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_HAND) then
				Duel.ConfirmCards(1-tp,tc)
				res=true
			end
		else
			if Duel.SendtoGrave(tc,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_GRAVE) then
				res=true
			end
		end
		local g2=Duel.GetMatchingGroup(c97520532.spfilter,tp,LOCATION_HAND,0,nil,e,tp)
		if res and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
			and not Duel.IsExistingMatchingCard(c97520532.cfilter,tp,LOCATION_MZONE,0,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(97520532,2)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local sg=g2:Select(tp,1,1,nil)
			Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
		end
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c97520532.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c97520532.splimit(e,c)
	return not (c:IsRace(RACE_MACHINE) and c:IsType(TYPE_XYZ)) and c:IsLocation(LOCATION_EXTRA)
end
