--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 影界王战 雷瓦汀王  (ID: 74615388)
-- Type: Monster / Effect / Xyz
-- Attribute: FIRE
-- Race: Fairy
-- Rank 9
-- ATK 2500 | DEF 2500
-- Setcode: 308
--
-- Effect Text:
-- 9星怪兽×2只以上
-- ①：「影界王战 雷瓦汀王」在自己场上只能有1只表侧表示存在。
-- ②：对方场上的怪兽的攻击力·守备力下降1000。
-- ③：自己·对方回合，把超量召唤的这张卡解放才能发动。从额外卡组把天使族怪兽以外的1只「王战」超量怪兽特殊召唤。那之后，可以选最多有这张卡持有的超量素材数量的自己或者对方的场上·墓地的卡在这个效果特殊召
-- 唤的怪兽下面重叠作为超量素材。
--[[ __CARD_HEADER_END__ ]]

--影の王 レイヴァーテイン
local s,id,o=GetID()
function s.initial_effect(c)
	c:SetUniqueOnField(1,0,id)
	--xyz summon
	aux.AddXyzProcedure(c,nil,9,2,nil,nil,99)
	c:EnableReviveLimit()
	--decrease atk/def
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(-1000)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
	--special summon xyz
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetRange(LOCATION_MZONE)
	e3:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e3:SetCost(s.spcost)
	e3:SetTarget(s.sptg)
	e3:SetOperation(s.spop)
	c:RegisterEffect(e3)
end
function s.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsReleasable() and c:IsSummonType(SUMMON_TYPE_XYZ) end
	local ct=c:GetOverlayCount()
	Duel.Release(c,REASON_COST)
	e:SetLabel(ct)
end
function s.filter(c,e,tp,rc)
	return not c:IsRace(RACE_FAIRY)
		and c:IsSetCard(0x134) and c:IsType(TYPE_XYZ)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.GetLocationCountFromEx(tp,tp,rc,c)>0
end
function s.mtfilter(c,e)
	return c:IsCanOverlay() and not c:IsImmuneToEffect(e)
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp,e:GetHandler()) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetLabel()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,e:GetHandler())
	if #g>0 then
		local tc=g:GetFirst()
		local mg=Duel.GetMatchingGroup(aux.NecroValleyFilter(s.mtfilter),tp,LOCATION_ONFIELD+LOCATION_GRAVE,LOCATION_ONFIELD+LOCATION_GRAVE,tc,e)
		if Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)>0 and ct>0
			and #mg>0 and Duel.SelectYesNo(tp,aux.Stringid(id,1)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
			local xg=mg:Select(tp,1,ct,nil)
			local tc1=xg:GetFirst()
			while tc1 do
				tc1:CancelToGrave()
				local og=tc1:GetOverlayGroup()
				if #og>0 then
					Duel.SendtoGrave(og,REASON_RULE)
				end
				tc1=xg:GetNext()
			end
			Duel.Overlay(tc,xg)
		end
	end
end
