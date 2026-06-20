--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 链·锁环龙  (ID: 19974580)
-- Type: Monster / Effect / Synchro
-- Attribute: EARTH
-- Race: Dragon
-- Level 6
-- ATK 2500 | DEF 1300
-- Setcode: 37
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- 可以把自己墓地存在的名字带有「链」的怪兽全部从游戏中除外。这个效果每除外1只怪兽，这张卡的攻击力直到这个回合的结束阶段时上升200。每次这张卡给与对方基本分战斗伤害，从对方卡组上面把3张卡送去墓地。
--[[ __CARD_HEADER_END__ ]]

--C・ドラゴン
function c19974580.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_ATKCHANGE)
	e1:SetDescription(aux.Stringid(19974580,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c19974580.attg)
	e1:SetOperation(c19974580.atop)
	c:RegisterEffect(e1)
	--discard deck
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(19974580,1))
	e2:SetCategory(CATEGORY_DECKDES)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetCondition(c19974580.ddcon)
	e2:SetTarget(c19974580.ddtg)
	e2:SetOperation(c19974580.ddop)
	c:RegisterEffect(e2)
end
function c19974580.rfilter(c)
	return c:IsSetCard(0x25) and c:IsAbleToRemove()
end
function c19974580.attg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c19974580.rfilter,tp,LOCATION_GRAVE,0,1,nil) end
	local g=Duel.GetMatchingGroup(c19974580.rfilter,tp,LOCATION_GRAVE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c19974580.atop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local g=Duel.GetMatchingGroup(c19974580.rfilter,tp,LOCATION_GRAVE,0,nil)
	local ct=Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	if ct>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(ct*200)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function c19974580.ddcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c19974580.ddtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,0,0,1-tp,3)
end
function c19974580.ddop(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(1-tp,3,REASON_EFFECT)
end
