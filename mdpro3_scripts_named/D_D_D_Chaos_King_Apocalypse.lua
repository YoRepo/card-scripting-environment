--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: DDD 极智王 混沌默示神  (ID: 83303851)
-- Type: Monster / Effect / Pendulum
-- Attribute: DARK
-- Race: Fiend
-- Level 7
-- Pendulum Scales: L4 / R4
-- ATK 2700 | DEF 2000
-- Setcode: 13570223
--
-- Effect Text:
-- ←4 【灵摆】 4→
-- ①：把自己墓地2只「DD」怪兽除外才能发动。灵摆区域的这张卡特殊召唤。
-- 【怪兽效果】
-- 「DDD 极智王 混沌默示神」的怪兽效果1回合只能使用1次，对方回合才能发动。
-- ①：这张卡在手卡·墓地存在的场合，以自己场上2张表侧表示的魔法·陷阱卡为对象才能发动。那些卡破坏，这张卡特殊召唤。这个效果的发动后，直到回合结束时自己不是恶魔族怪兽不能特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--DDD極智王カオス・アポカリプス
function c83303851.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(83303851,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCost(c83303851.spcost)
	e1:SetTarget(c83303851.sptg)
	e1:SetOperation(c83303851.spop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(83303851,1))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1,83303851)
	e2:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e2:SetCondition(c83303851.descon)
	e2:SetTarget(c83303851.destg)
	e2:SetOperation(c83303851.desop)
	c:RegisterEffect(e2)
end
function c83303851.cfilter(c)
	return c:IsSetCard(0xaf) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c83303851.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c83303851.cfilter,tp,LOCATION_GRAVE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c83303851.cfilter,tp,LOCATION_GRAVE,0,2,2,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c83303851.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c83303851.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c83303851.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c83303851.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c83303851.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local ct=-ft+1
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and c83303851.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c83303851.filter,tp,LOCATION_ONFIELD,0,2,nil)
		and ct<=2 and (ct<=0 or Duel.IsExistingTarget(c83303851.filter,tp,LOCATION_MZONE,0,ct,nil))
		and not c:IsStatus(STATUS_CHAINING) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=nil
	if ct<=0 then
		g=Duel.SelectTarget(tp,c83303851.filter,tp,LOCATION_ONFIELD,0,2,2,nil)
	elseif ct==1 then
		g=Duel.SelectTarget(tp,c83303851.filter,tp,LOCATION_MZONE,0,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g2=Duel.SelectTarget(tp,c83303851.filter,tp,LOCATION_ONFIELD,0,1,1,g:GetFirst())
		g:Merge(g2)
	else
		g=Duel.SelectTarget(tp,c83303851.filter,tp,LOCATION_MZONE,0,2,2,nil)
	end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c83303851.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c83303851.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()>0 and Duel.Destroy(g,REASON_EFFECT)~=0 then
		local c=e:GetHandler()
		if not c:IsRelateToEffect(e) then return end
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c83303851.splimit(e,c)
	return c:GetRace()~=RACE_FIEND
end
