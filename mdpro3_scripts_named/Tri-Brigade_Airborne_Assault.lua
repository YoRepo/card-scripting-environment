--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 铁兽的凶袭  (ID: 51097887)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 333
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：以自己场上1只兽族·兽战士族·鸟兽族怪兽为对象才能发动。那只怪兽的攻击力以下而种族不同的1只兽族·兽战士族·鸟兽族怪兽从卡组守备表示特殊召唤。这个效果特殊召唤的怪兽的效果直到回合结束时无效化。这个
-- 效果的发动后，直到回合结束时自己不是连接怪兽不能从额外卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--鉄獣の凶襲
function c51097887.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCountLimit(1,51097887+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c51097887.sptg)
	e1:SetOperation(c51097887.spop)
	c:RegisterEffect(e1)
end
function c51097887.spfilter1(c,e,tp)
	return c:IsFaceup() and c:IsRace(RACE_BEAST+RACE_BEASTWARRIOR+RACE_WINDBEAST)
		and Duel.IsExistingMatchingCard(c51097887.spfilter2,tp,LOCATION_DECK,0,1,nil,e,tp,c:GetAttack(),c:GetRace())
end
function c51097887.spfilter2(c,e,tp,atk,race)
	return c:IsRace(RACE_BEAST+RACE_BEASTWARRIOR+RACE_WINDBEAST) and c:IsAttackBelow(atk) and not c:IsRace(race)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c51097887.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c51097887.spfilter1(chkc,e,tp) end
	if chk==0 then return Duel.GetMZoneCount(tp)>0
		and Duel.IsExistingTarget(c51097887.spfilter1,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c51097887.spfilter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c51097887.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c51097887.spfilter2,tp,LOCATION_DECK,0,1,1,nil,e,tp,tc:GetAttack(),tc:GetRace())
		local tc=g:GetFirst()
		if tc then
			Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e1)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_DISABLE_EFFECT)
			e2:SetValue(RESET_TURN_SET)
			tc:RegisterEffect(e2)
			Duel.SpecialSummonComplete()
		end
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c51097887.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c51097887.splimit(e,c)
	return not c:IsType(TYPE_LINK) and c:IsLocation(LOCATION_EXTRA)
end
