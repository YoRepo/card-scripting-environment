--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 龙骑兵团-阔头枪龙  (ID: 25988873)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Dragon
-- Level 2
-- ATK 1200 | DEF 800
-- Setcode: 41
--
-- Effect Text:
-- 这张卡召唤成功时，可以从手卡把1只名字带有「龙骑兵团」的鸟兽族怪兽特殊召唤，把这张卡当作装备卡使用来装备。这张卡被卡的效果当作装备卡使用装备中的场合，装备怪兽当作调整使用。
--[[ __CARD_HEADER_END__ ]]

--ドラグニティ－パルチザン
function c25988873.initial_effect(c)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(25988873,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c25988873.sptg)
	e1:SetOperation(c25988873.spop)
	c:RegisterEffect(e1)
	--add type
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_ADD_TYPE)
	e2:SetValue(TYPE_TUNER)
	c:RegisterEffect(e2)
end
function c25988873.filter(c,e,tp)
	return c:IsSetCard(0x29) and c:IsRace(RACE_WINDBEAST) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c25988873.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(c25988873.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c25988873.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c25988873.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if not tc then return end
	Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	local c=e:GetHandler()
	if c:IsFacedown() or not c:IsRelateToEffect(e) or c:IsControler(1-tp)
		or Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.BreakEffect()
	if not Duel.Equip(tp,c,tc,false) then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EQUIP_LIMIT)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	e1:SetValue(c25988873.eqlimit)
	e1:SetLabelObject(tc)
	c:RegisterEffect(e1)
end
function c25988873.eqlimit(e,c)
	return e:GetLabelObject()==c
end
