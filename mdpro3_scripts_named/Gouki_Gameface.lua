--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 刚鬼斗魂  (ID: 95448372)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 252
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张，这个卡名的②的效果1回合只能使用1次。
-- ①：作为这张卡的发动时的效果处理，可以从手卡把1只4星以下而战士族·恐龙族·电子界族的地属性怪兽守备表示特殊召唤。
-- ②：把自己场上1只连接3以上的「刚鬼」怪兽解放才能发动。从卡组·额外卡组把1只「恐龙摔跤手」怪兽或「G石人」怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--剛鬼闘魂
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,id)
	e2:SetCost(s.spcost)
	e2:SetTarget(s.sptg)
	e2:SetOperation(s.spop)
	c:RegisterEffect(e2)
end
function s.spfilter(c,e,sp)
	return c:IsLevelBelow(4) and c:IsAttribute(ATTRIBUTE_EARTH)
		and c:IsRace(RACE_WARRIOR+RACE_DINOSAUR+RACE_CYBERSE)
		and c:IsCanBeSpecialSummoned(e,0,sp,false,false,POS_FACEUP_DEFENSE)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local cg=Duel.GetMatchingGroup(s.spfilter,tp,LOCATION_HAND,0,nil,e,tp)
	if #cg>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.SelectYesNo(tp,aux.Stringid(id,2)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=cg:Select(tp,1,1,nil)
		Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
function s.costfilter(c,e,tp)
	return c:IsSetCard(0xfc) and c:IsLinkAbove(3)
		and Duel.IsExistingMatchingCard(s.spfilter2,tp,LOCATION_DECK+LOCATION_EXTRA,0,1,nil,e,tp,c)
end
function s.spfilter2(c,e,tp,ec)
	return c:IsSetCard(0x11a,0x186) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and (c:IsLocation(LOCATION_DECK) and Duel.GetMZoneCount(tp,ec)>0
		or c:IsLocation(LOCATION_EXTRA) and Duel.GetLocationCountFromEx(tp,tp,ec,c)>0)
end
function s.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,s.costfilter,1,nil,e,tp) end
	local g=Duel.SelectReleaseGroup(tp,s.costfilter,1,1,nil,e,tp)
	Duel.Release(g,REASON_COST)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:IsCostChecked() end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_EXTRA)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,s.spfilter2,tp,LOCATION_DECK+LOCATION_EXTRA,0,1,1,nil,e,tp,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
