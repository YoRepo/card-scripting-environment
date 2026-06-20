--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 护宝炮妖欢乐制造机  (ID: 48285768)
-- Type: Monster / Effect / Xyz
-- Attribute: FIRE
-- Race: Machine
-- Rank 4
-- ATK 1100 | DEF 2000
-- Setcode: 341
--
-- Effect Text:
-- 4星怪兽×2
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡从额外卡组特殊召唤的场合才能发动。从卡组把1只「护宝炮妖」怪兽送去墓地。
-- ②：对方的主要阶段以及战斗阶段才能发动。这张卡直到结束阶段除外。把持有超量素材2个以上的这张卡除外的场合，可以再从额外卡组把以「阿不思的落胤」为融合素材的1只融合怪兽送去墓地。
--[[ __CARD_HEADER_END__ ]]

--スプリガンズ・メリーメイカー
local s,id,o=GetID()
function c48285768.initial_effect(c)
	aux.AddCodeList(c,68468459)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
	--tograve
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(48285768,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,48285768)
	e1:SetCondition(c48285768.tgcon)
	e1:SetTarget(c48285768.tgtg)
	e1:SetOperation(c48285768.tgop)
	c:RegisterEffect(e1)
	--banish temporary
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(48285768,1))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetHintTiming(0,TIMING_MAIN_END+TIMING_BATTLE_START+TIMING_BATTLE_END)
	e2:SetCountLimit(1,48285768)
	e2:SetCondition(c48285768.rmcon)
	e2:SetTarget(c48285768.rmtg)
	e2:SetOperation(c48285768.rmop)
	c:RegisterEffect(e2)
end
function c48285768.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonLocation(LOCATION_EXTRA)
end
function c48285768.tgfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x155) and c:IsAbleToGrave()
end
function c48285768.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c48285768.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c48285768.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c48285768.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
function c48285768.rmcon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return Duel.GetTurnPlayer()~=tp and (ph==PHASE_MAIN1 or (ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE) or ph==PHASE_MAIN2)
end
function c48285768.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,e:GetHandler(),1,0,0)
end
function c48285768.exfilter(c)
	return c:IsType(TYPE_FUSION) and aux.IsMaterialListCode(c,68468459)
end
function c48285768.rmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local ct=c:GetOverlayCount()
		if Duel.Remove(c,0,REASON_EFFECT+REASON_TEMPORARY)~=0 and c:GetOriginalCode()==id then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e1:SetCode(EVENT_PHASE+PHASE_END)
			e1:SetReset(RESET_PHASE+PHASE_END)
			e1:SetLabelObject(c)
			e1:SetCountLimit(1)
			e1:SetOperation(c48285768.retop)
			Duel.RegisterEffect(e1,tp)
		end
		if ct>=2 and Duel.IsExistingMatchingCard(c48285768.exfilter,tp,LOCATION_EXTRA,0,1,nil)
			and Duel.SelectYesNo(tp,aux.Stringid(48285768,2)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
			local g=Duel.SelectMatchingCard(tp,c48285768.exfilter,tp,LOCATION_EXTRA,0,1,1,nil)
			if g:GetCount()>0 then
				Duel.SendtoGrave(g,REASON_EFFECT)
			end
		end
	end
end
function c48285768.retop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ReturnToField(e:GetLabelObject())
end
