--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 暗跃的德鲁伊·橡木  (ID: 24062258)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 4
-- ATK 1800 | DEF 0
--
-- Effect Text:
-- 这张卡召唤成功时，可以从自己墓地选择「暗跃的德鲁伊·橡木」以外的1只攻击力或者守备力是0的暗属性·4星怪兽表侧守备表示特殊召唤。这个效果特殊召唤的怪兽的效果无效化。「暗跃的德鲁伊·橡木」的效果1回合只
-- 能使用1次。
--[[ __CARD_HEADER_END__ ]]

--暗躍のドルイド・ドリュース
function c24062258.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(24062258,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,24062258)
	e1:SetTarget(c24062258.sptg)
	e1:SetOperation(c24062258.spop)
	c:RegisterEffect(e1)
end
function c24062258.filter(c,e,tp)
	return not c:IsCode(24062258) and c:IsLevel(4) and c:IsAttribute(ATTRIBUTE_DARK) and (c:IsAttack(0) or c:IsDefense(0))
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c24062258.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c24062258.filter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c24062258.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c24062258.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c24062258.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP_DEFENSE) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e2)
	end
	Duel.SpecialSummonComplete()
end
