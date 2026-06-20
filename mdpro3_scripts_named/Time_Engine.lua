--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 时间机械-时间引擎  (ID: 15216188)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 442
--
-- Effect Text:
-- 这个卡名在规则上也当作「金属化」卡使用。
-- ①：自己场上的怪兽被战斗或者对方的效果破坏的场合，以那之内的1只为对象才能发动。那只怪兽特殊召唤。这个效果把5星以上的机械族怪兽特殊召唤，自己的场上或墓地有这张卡以外的「金属化」陷阱卡存在的场合，可以
-- 再让以下效果适用。
-- ●对方场上的怪兽全部破坏。那之后，可以给与对方这个效果特殊召唤的怪兽的原本攻击力数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--時の機械－タイム・エンジン
local s,id,o=GetID()
function s.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CUSTOM+id)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCondition(s.condition)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
	aux.RegisterMergedDelayedEvent(c,id,EVENT_DESTROYED)
end
function s.cfilter(c,tp)
	return c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_MZONE)
		and not c:IsType(TYPE_TOKEN)
		and (c:IsReason(REASON_BATTLE) or c:IsReason(REASON_EFFECT) and c:GetReasonPlayer()==1-tp)
end
function s.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.cfilter,1,nil,tp) and not eg:IsContains(e:GetHandler())
end
function s.tgfilter(c,e,tp)
	return c:IsCanBeEffectTarget(e) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local mg=eg:Filter(s.cfilter,nil,tp):Filter(s.tgfilter,nil,e,tp)
	if chkc then return mg:IsContains(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and mg:GetCount()>0 end
	local g=mg
	if mg:GetCount()>1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		g=mg:Select(tp,1,1,nil)
	end
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function s.dcfilter(c)
	return c:IsFaceupEx() and c:IsSetCard(0x1ba) and c:IsType(TYPE_TRAP)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and aux.NecroValleyFilter()(tc) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		if Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)~=0
			and tc:IsRace(RACE_MACHINE) and tc:IsLevelAbove(5)
			and Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_MZONE,1,nil)
			and Duel.IsExistingMatchingCard(s.dcfilter,tp,LOCATION_SZONE+LOCATION_GRAVE,0,1,aux.ExceptThisCard(e))
			and Duel.SelectYesNo(tp,aux.Stringid(id,2)) then
			Duel.BreakEffect()
			local sg=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
			if sg:GetCount()>0 and Duel.Destroy(sg,REASON_EFFECT)~=0
				and tc:GetBaseAttack()>0 and Duel.SelectYesNo(tp,aux.Stringid(id,3)) then
				Duel.BreakEffect()
				Duel.Damage(1-tp,tc:GetBaseAttack(),REASON_EFFECT)
			end
		end
	end
end
