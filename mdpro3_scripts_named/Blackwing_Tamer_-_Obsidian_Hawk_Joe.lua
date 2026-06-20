--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 黑羽驯鸟师-漆黑之鹰匠·乔  (ID: 81983656)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Warrior
-- Level 7
-- ATK 2600 | DEF 2000
-- Setcode: 51
--
-- Effect Text:
-- 「黑羽」调整＋调整以外的「黑羽」怪兽1只以上
-- 「黑羽驯鸟师-漆黑之鹰匠·乔」的①②的效果1回合各能使用1次。
-- ①：以自己墓地1只5星以上的鸟兽族怪兽为对象才能发动。那只怪兽特殊召唤。
-- ②：这张卡成为对方的效果的对象时或者成为对方怪兽的攻击对象时，以这张卡以外的自己场上1只「黑羽」怪兽为对象才能发动。那个对象转移为作为正确对象的那只怪兽。
--[[ __CARD_HEADER_END__ ]]

--BF T－漆黒のホーク・ジョー
function c81983656.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x33),aux.NonTuner(Card.IsSetCard,0x33),1)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(81983656,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,81983656)
	e1:SetTarget(c81983656.sptg)
	e1:SetOperation(c81983656.spop)
	c:RegisterEffect(e1)
	--change battle target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,81983657)
	e2:SetCondition(c81983656.cbcon)
	e2:SetTarget(c81983656.cbtg)
	e2:SetOperation(c81983656.cbop)
	c:RegisterEffect(e2)
	--change effect target
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_CHAINING)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,81983657)
	e3:SetCondition(c81983656.cecon)
	e3:SetTarget(c81983656.cetg)
	e3:SetOperation(c81983656.ceop)
	c:RegisterEffect(e3)
end
function c81983656.spfilter(c,e,tp)
	return c:IsLevelAbove(5) and c:IsRace(RACE_WINDBEAST) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c81983656.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c81983656.spfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c81983656.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c81983656.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c81983656.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c81983656.cbcon(e,tp,eg,ep,ev,re,r,rp)
	return r~=REASON_REPLACE and Duel.GetAttackTarget()==e:GetHandler()
end
function c81983656.cbfilter(c,at)
	return c:IsFaceup() and c:IsSetCard(0x33) and at:IsContains(c)
end
function c81983656.cbtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local at=Duel.GetAttacker():GetAttackableTarget()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c81983656.cbfilter(chkc,at) end
	if chk==0 then return Duel.IsExistingTarget(c81983656.cbfilter,tp,LOCATION_MZONE,0,1,e:GetHandler(),at) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c81983656.cbfilter,tp,LOCATION_MZONE,0,1,1,e:GetHandler(),at)
end
function c81983656.cbop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and not Duel.GetAttacker():IsImmuneToEffect(e) then
		Duel.ChangeAttackTarget(tc)
	end
end
function c81983656.cecon(e,tp,eg,ep,ev,re,r,rp)
	if e==re or rp==tp or not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return g and g:GetCount()==1 and g:GetFirst()==e:GetHandler()
end
function c81983656.cefilter(c,ct)
	return c:IsFaceup() and c:IsSetCard(0x33) and Duel.CheckChainTarget(ct,c)
end
function c81983656.cetg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c81983656.cefilter(chkc,ev) end
	if chk==0 then return Duel.IsExistingTarget(c81983656.cefilter,tp,LOCATION_MZONE,0,1,e:GetHandler(),ev) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c81983656.cefilter,tp,LOCATION_MZONE,0,1,1,e:GetHandler(),ev)
end
function c81983656.ceop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.ChangeTargetCard(ev,Group.FromCards(tc))
	end
end
