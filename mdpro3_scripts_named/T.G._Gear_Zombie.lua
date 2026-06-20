--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 科技属 齿轮僵尸  (ID: 94350039)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Zombie
-- Level 1
-- ATK 600 | DEF 0
-- Setcode: 39
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：以自己场上1只「科技属」怪兽为对象才能发动。这张卡从手卡特殊召唤。那之后，作为对象的怪兽的攻击力下降1000。
--[[ __CARD_HEADER_END__ ]]

--TG ギア・ゾンビ
function c94350039.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(94350039,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,94350039)
	e1:SetTarget(c94350039.sptg)
	e1:SetOperation(c94350039.spop)
	c:RegisterEffect(e1)
end
function c94350039.cfilter(c)
	return c:IsSetCard(0x27) and c:IsFaceup()
end
function c94350039.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c94350039.cfilter(chkc) end
	local c=e:GetHandler()
	if chk==0 then return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c94350039.cfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c94350039.cfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c94350039.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
		local tc=Duel.GetFirstTarget()
		if tc:IsFaceup() and tc:IsRelateToEffect(e) then
			Duel.BreakEffect()
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			e1:SetValue(-1000)
			tc:RegisterEffect(e1)
		end
	end
end
