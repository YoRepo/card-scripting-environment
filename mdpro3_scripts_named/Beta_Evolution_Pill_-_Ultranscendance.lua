--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 超越进化药β  (ID: 23969415)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 270
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从自己的手卡·场上把包含恐龙族怪兽的2只怪兽解放才能发动。把持有解放的怪兽的攻击力合计以上的攻击力的1只5星以上的恐龙族怪兽从卡组·额外卡组特殊召唤。这张卡的发动后，直到回合结束时自己不是龙族·恐
-- 龙族·海龙族·幻龙族怪兽不能从额外卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--超越進化薬β
local s,id,o=GetID()
function s.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.costfilter(c,tp)
	return c:IsControler(tp) or c:IsFaceup()
end
function s.gcheck(g,e,tp)
	return g:IsExists(Card.IsRace,1,nil,RACE_DINOSAUR)
		and Duel.IsExistingMatchingCard(s.spfilter,tp,LOCATION_DECK+LOCATION_EXTRA,0,1,nil,e,tp,g,g:GetSum(Card.GetAttack))
end
function s.spfilter(c,e,tp,g,atk)
	local check=false
	if c:IsLocation(LOCATION_DECK) then
		check=Duel.GetMZoneCount(tp,g)>0
	elseif c:IsLocation(LOCATION_EXTRA) then
		check=Duel.GetLocationCountFromEx(tp,tp,g,c)>0
	end
	return check and c:IsLevelAbove(5) and c:IsRace(RACE_DINOSAUR) and c:IsAttackAbove(atk)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetReleaseGroup(tp,true):Filter(s.costfilter,nil,tp)
	if chk==0 then return e:IsCostChecked()
		and g:CheckSubGroup(s.gcheck,2,2,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local sg=g:SelectSubGroup(tp,s.gcheck,false,2,2,e,tp)
	local atk=sg:GetSum(Card.GetAttack)
	Duel.Release(sg,REASON_COST)
	e:SetLabel(atk)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_EXTRA)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local atk=e:GetLabel()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,s.spfilter,tp,LOCATION_DECK+LOCATION_EXTRA,0,1,1,nil,e,tp,nil,atk)
	if #g>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		e1:SetTargetRange(1,0)
		e1:SetTarget(s.splimit)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
	end
end
function s.splimit(e,c)
	return not c:IsRace(RACE_DRAGON+RACE_DINOSAUR+RACE_SEASERPENT+RACE_WYRM) and c:IsLocation(LOCATION_EXTRA)
end
