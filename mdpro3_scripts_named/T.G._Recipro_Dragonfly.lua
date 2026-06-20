--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 科技属 互换蜻蜓  (ID: 62560742)
-- Type: Monster / Effect / Synchro
-- Attribute: WIND
-- Race: Insect
-- Level 2
-- ATK 300 | DEF 300
-- Setcode: 39
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只
-- ①：1回合1次，以自己场上1只其他的「科技属」同调怪兽为对象才能发动。那只怪兽送去墓地。那之后，若作为送去墓地的那只怪兽的同调召唤的素材用过的一组怪兽全部是同调怪兽并在自己墓地齐集，可以把那一组特殊召
-- 唤。
--[[ __CARD_HEADER_END__ ]]

--TG レシプロ・ドラゴン・フライ
function c62560742.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1,1)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(62560742,0))
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c62560742.target)
	e1:SetOperation(c62560742.operation)
	c:RegisterEffect(e1)
end
function c62560742.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x27) and c:IsType(TYPE_SYNCHRO)
end
function c62560742.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c62560742.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c62560742.filter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(62560742,2))
	local g=Duel.SelectTarget(tp,c62560742.filter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
end
function c62560742.mgfilter(c,e,tp,sync)
	return c:IsControler(tp) and c:IsLocation(LOCATION_GRAVE) and c:IsType(TYPE_SYNCHRO)
		and bit.band(c:GetReason(),0x80008)==0x80008 and c:GetReasonCard()==sync
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c62560742.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	local mg=tc:GetMaterial()
	local ct=mg:GetCount()
	local sumtype=tc:GetSummonType()
	if Duel.SendtoGrave(tc,REASON_EFFECT)~=0 and sumtype==SUMMON_TYPE_SYNCHRO
		and ct>0 and not Duel.IsPlayerAffectedByEffect(tp,59822133)
		and ct<=Duel.GetLocationCount(tp,LOCATION_MZONE)
		and mg:FilterCount(aux.NecroValleyFilter(c62560742.mgfilter),nil,e,tp,tc)==ct
		and Duel.SelectYesNo(tp,aux.Stringid(62560742,1)) then
		Duel.BreakEffect()
		Duel.SpecialSummon(mg,0,tp,tp,false,false,POS_FACEUP)
	end
end
