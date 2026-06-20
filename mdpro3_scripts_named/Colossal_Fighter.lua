--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 巨人斗士  (ID: 23693634)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Warrior
-- Level 8
-- ATK 2800 | DEF 1000
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- 这张卡的攻击力上升双方墓地的战士族怪兽数量×100的数值。这张卡被战斗破坏送去墓地时，可以选择自己或者对方的墓地1只战士族怪兽在自己场上特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ギガンテック・ファイター
function c23693634.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--Atk up
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c23693634.atkval)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(23693634,0))
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetCondition(c23693634.sumcon)
	e2:SetTarget(c23693634.sumtg)
	e2:SetOperation(c23693634.sumop)
	c:RegisterEffect(e2)
end
function c23693634.atkval(e,c)
	return Duel.GetMatchingGroupCount(Card.IsRace,c:GetControler(),LOCATION_GRAVE,LOCATION_GRAVE,nil,RACE_WARRIOR)*100
end
function c23693634.sumcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetLocation()==LOCATION_GRAVE
		and bit.band(e:GetHandler():GetReason(),REASON_BATTLE)~=0
end
function c23693634.filter(c,e,tp)
	return c:IsRace(RACE_WARRIOR) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c23693634.sumtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c23693634.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c23693634.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c23693634.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c23693634.sumop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsRace(RACE_WARRIOR) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
