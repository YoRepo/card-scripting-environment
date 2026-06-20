--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 御用捕食者  (ID: 98637386)
-- Type: Monster / Effect / Synchro
-- Attribute: EARTH
-- Race: Warrior
-- Level 6
-- ATK 2400 | DEF 1200
-- Setcode: 243
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- 「御用捕食者」的效果1回合只能使用1次。
-- ①：这张卡战斗破坏对方怪兽送去墓地时才能发动。那只怪兽在自己场上特殊召唤。这个效果特殊召唤的怪兽给与玩家的战斗伤害变成一半。
--[[ __CARD_HEADER_END__ ]]

--ゴヨウ・プレデター
function c98637386.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(98637386,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCountLimit(1,98637386)
	e1:SetCondition(aux.bdogcon)
	e1:SetTarget(c98637386.sptg)
	e1:SetOperation(c98637386.spop)
	c:RegisterEffect(e1)
end
function c98637386.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local bc=e:GetHandler():GetBattleTarget()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and bc:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetTargetCard(bc)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,bc,1,0,0)
end
function c98637386.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		if Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
			e1:SetCode(EFFECT_CHANGE_BATTLE_DAMAGE)
			e1:SetValue(HALF_DAMAGE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			tc:RegisterEffect(e1,true)
		end
		Duel.SpecialSummonComplete()
	end
end
