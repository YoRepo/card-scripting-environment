--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 旧神 诺登  (ID: 17412721)
-- Type: Monster / Effect / Fusion
-- Attribute: WATER
-- Race: Fairy
-- Level 4
-- ATK 2000 | DEF 2200
-- Setcode: 183
--
-- Effect Text:
-- 同调怪兽或超量怪兽＋同调怪兽或超量怪兽
-- ①：这张卡特殊召唤成功时，以自己墓地1只4星以下的怪兽为对象才能发动。那只怪兽效果无效特殊召唤。这张卡从场上离开时那只怪兽除外。
--[[ __CARD_HEADER_END__ ]]

--旧神ノーデン
function c17412721.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,c17412721.ffilter,c17412721.ffilter,true)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(17412721,1))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(c17412721.sptg)
	e1:SetOperation(c17412721.spop)
	c:RegisterEffect(e1)
	--leave field
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetOperation(c17412721.leave)
	c:RegisterEffect(e2)
	e1:SetLabelObject(e2)
end
c17412721.material_type=TYPE_SYNCHRO
function c17412721.ffilter(c)
	return c:IsFusionType(TYPE_XYZ+TYPE_SYNCHRO)
end
function c17412721.filter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c17412721.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c17412721.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c17412721.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c17412721.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c17412721.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1,true)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e2,true)
		if c:IsRelateToEffect(e) then
			c:SetCardTarget(tc)
			e:GetLabelObject():SetLabelObject(tc)
			c:CreateRelation(tc,RESET_EVENT+0x5020000)
			tc:CreateRelation(c,RESET_EVENT+0x5fe0000)
		end
	end
	Duel.SpecialSummonComplete()
end
function c17412721.leave(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=e:GetLabelObject()
	if tc and c:IsRelateToCard(tc) and tc:IsRelateToCard(c) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
