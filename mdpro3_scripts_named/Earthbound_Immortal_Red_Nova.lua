--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 地缚神 真红莲新星  (ID: 5267507)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 12
-- ATK 3500 | DEF 3000
-- Setcode: 4129
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：「地缚神」怪兽在场上只能有1只表侧表示存在。
-- ②：自己·对方的主要阶段，把手卡·墓地的这张卡除外才能发动。从自己的手卡·场上（表侧表示）把1只「地缚神」怪兽或「红莲魔龙」送去墓地。那之后，可以从以下效果让1个适用。
-- ●从卡组·额外卡组把1只「地缚」怪兽特殊召唤。
-- ●从额外卡组把1只「真红莲新星龙」当作同调召唤作特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--地縛神 スカーレッド・ノヴァ
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,70902743,97489701)
	c:SetUniqueOnField(1,1,aux.FilterBoolFunction(Card.IsSetCard,0x1021),LOCATION_MZONE)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_SPECIAL_SUMMON+CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetHintTiming(0,TIMING_MAIN_END)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCountLimit(1,id)
	e1:SetCondition(s.spcon)
	e1:SetCost(s.spcost)
	e1:SetTarget(s.sptg)
	e1:SetOperation(s.spop)
	c:RegisterEffect(e1)
end
function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2
end
function s.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function s.tgfilter(c)
	return c:IsFaceupEx() and c:IsAbleToGrave() and (c:IsCode(70902743) or (c:IsSetCard(0x1021) and c:IsType(TYPE_MONSTER)))
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.tgfilter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,e:GetHandler()) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_MZONE)
end
function s.spfilter(c,e,tp)
	return ((c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsSetCard(0x21))
		or (c:IsCode(97489701) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SYNCHRO,tp,false,false)))
		and (c:IsLocation(LOCATION_DECK) and Duel.GetMZoneCount(tp)>0
			or c:IsLocation(LOCATION_EXTRA) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local tc=Duel.SelectMatchingCard(tp,s.tgfilter,tp,LOCATION_HAND+LOCATION_ONFIELD,0,1,1,nil):GetFirst()
	if tc and Duel.SendtoGrave(tc,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_GRAVE)
		and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_DECK+LOCATION_EXTRA,0,1,nil,e,tp)
		and Duel.SelectYesNo(tp,aux.Stringid(id,1)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local spc=Duel.SelectMatchingCard(tp,s.spfilter,tp,LOCATION_DECK+LOCATION_EXTRA,0,1,1,nil,e,tp):GetFirst()
		if spc then
			if spc:IsCode(97489701) then
				if Duel.SpecialSummon(spc,SUMMON_TYPE_SYNCHRO,tp,tp,false,false,POS_FACEUP) then
					spc:CompleteProcedure()
				end
			else
				Duel.SpecialSummon(spc,0,tp,tp,false,false,POS_FACEUP)
			end
		end
	end
end
