--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 御用守护者  (ID: 7391448)
-- Type: Monster / Effect / Synchro
-- Attribute: EARTH
-- Race: Warrior
-- Level 6
-- ATK 2800 | DEF 2000
-- Setcode: 82
--
-- Effect Text:
-- 地属性调整＋调整以外的怪兽1只以上
-- ①：这张卡战斗破坏对方怪兽送去墓地时才能发动。那只怪兽在自己场上守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ゴヨウ・ガーディアン
function c7391448.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_EARTH),aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(7391448,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCondition(aux.bdogcon)
	e1:SetTarget(c7391448.sptg)
	e1:SetOperation(c7391448.spop)
	c:RegisterEffect(e1)
end
function c7391448.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local bc=e:GetHandler():GetBattleTarget()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and bc:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE) end
	Duel.SetTargetCard(bc)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,bc,1,0,0)
end
function c7391448.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
