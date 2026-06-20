--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 斩机方程式  (ID: 14025912)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 306
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：以自己墓地1只「斩机」怪兽为对象才能发动。那只怪兽特殊召唤。这个效果特殊召唤的怪兽的攻击力直到回合结束时上升1000。
--[[ __CARD_HEADER_END__ ]]

--斬機方程式
function c14025912.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,14025912+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c14025912.target)
	e1:SetOperation(c14025912.activate)
	c:RegisterEffect(e1)
end
function c14025912.filter(c,e,tp)
	return c:IsSetCard(0x132) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c14025912.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c14025912.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c14025912.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c14025912.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c14025912.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(1000)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
	Duel.SpecialSummonComplete()
end
