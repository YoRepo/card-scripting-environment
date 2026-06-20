--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 超骑甲虫 绝对大力独角仙  (ID: 50855622)
-- Type: Monster / Effect / Fusion
-- Attribute: EARTH
-- Race: Insect
-- Level 11
-- ATK 4000 | DEF 4000
-- Setcode: 368
--
-- Effect Text:
-- 昆虫族怪兽×4
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：这张卡融合召唤成功的场合，这张卡直到下次的自己回合的结束时不受其他卡的效果影响。
-- ②：自己·对方的战斗阶段结束时，以自己墓地1只攻击力3000以下的昆虫族怪兽为对象才能发动。那只怪兽特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--超騎甲虫アブソリュート・ヘラクレス
function c50855622.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsRace,RACE_INSECT),4,true)
	--unaffected
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c50855622.regcon)
	e1:SetOperation(c50855622.regop)
	c:RegisterEffect(e1)
	--sp summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(50855622,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e2:SetCountLimit(1,50855622)
	e2:SetTarget(c50855622.sptg)
	e2:SetOperation(c50855622.spop)
	c:RegisterEffect(e2)
end
function c50855622.regcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_FUSION)
end
function c50855622.regop(e,tp,eg,ep,ev,re,r,rp)
	--unaffected handle after it was summoned
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c50855622.efilter)
	if Duel.GetTurnPlayer()==tp then
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
	else
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END+RESET_SELF_TURN,1)
	end
	e:GetHandler():RegisterEffect(e1)
end
function c50855622.efilter(e,te)
	return te:GetOwner()~=e:GetOwner()
end
function c50855622.spfilter(c,e,tp)
	return c:IsRace(RACE_INSECT) and c:IsAttackBelow(3000) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c50855622.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c50855622.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c50855622.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c50855622.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c50855622.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
