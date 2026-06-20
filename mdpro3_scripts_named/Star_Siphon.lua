--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 星食-等级攀升-  (ID: 70391588)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 同调怪兽特殊召唤时，选择那1只怪兽发动。在自己场上把1只「星食衍生物」（魔法师族·暗·1星·攻/守0）特殊召唤。这衍生物的等级变成和选择的怪兽相同的等级，选择的怪兽的等级变成1星。
--[[ __CARD_HEADER_END__ ]]

--星蝕－レベル・クライム－
function c70391588.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(c70391588.target)
	e1:SetOperation(c70391588.activate)
	c:RegisterEffect(e1)
end
function c70391588.filter(c,e,tp)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO) and c:IsCanBeEffectTarget(e)
		and Duel.IsPlayerCanSpecialSummonMonster(tp,70391589,0,TYPES_TOKEN_MONSTER,0,0,c:GetLevel(),RACE_SPELLCASTER,ATTRIBUTE_DARK)
end
function c70391588.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return eg:IsContains(chkc) and c70391588.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and eg:IsExists(c70391588.filter,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=eg:FilterSelect(tp,c70391588.filter,1,1,nil,e,tp)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c70391588.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	local lv=1
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		lv=tc:GetLevel()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,70391589,0,TYPES_TOKEN_MONSTER,0,0,lv,RACE_SPELLCASTER,ATTRIBUTE_DARK) then return end
	local token=Duel.CreateToken(tp,70391589)
	Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CHANGE_LEVEL)
	e2:SetValue(lv)
	e2:SetReset(RESET_EVENT+RESETS_STANDARD)
	token:RegisterEffect(e2)
	Duel.SpecialSummonComplete()
end
