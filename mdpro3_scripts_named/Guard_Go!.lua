--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 我怒隆共防！  (ID: 64283880)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：自己场上的「我我我」、「怒怒怒」、「隆隆隆」怪兽的其中任意种被战斗·效果破坏送去墓地的场合，以那1只怪兽为对象才能发动。那只怪兽特殊召唤。那之后，可以从手卡把「我我我」、「怒怒怒」、「隆隆隆」怪兽
-- 合计最多2只守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ガードゴー！
function c64283880.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetTarget(c64283880.sptg)
	e1:SetOperation(c64283880.spop)
	c:RegisterEffect(e1)
end
function c64283880.filter(c,e,tp)
	return c:IsReason(REASON_DESTROY) and c:IsReason(REASON_BATTLE+REASON_EFFECT)
		and c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousPosition(POS_FACEUP)
		and c:IsPreviousControler(tp) and c:IsSetCard(0x54,0x82,0x59)
		and c:IsCanBeEffectTarget(e) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c64283880.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return eg:IsContains(chkc) and c64283880.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and eg:IsExists(c64283880.filter,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=eg:FilterSelect(tp,c64283880.filter,1,1,nil,e,tp)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c64283880.spfilter(c,e,tp)
	return c:IsSetCard(0x54,0x82,0x59) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c64283880.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)~=0 then
		local ct=Duel.GetLocationCount(tp,LOCATION_MZONE)
		if ct<=0 then return end
		local g=Duel.GetMatchingGroup(c64283880.spfilter,tp,LOCATION_HAND,0,nil,e,tp)
		if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(64283880,0)) then
			Duel.BreakEffect()
			if ct>2 then ct=2 end
			if Duel.IsPlayerAffectedByEffect(tp,59822133) then ct=1 end
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local sg=g:Select(tp,1,ct,nil)
			Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
		end
	end
end
