--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 奇迹的供物  (ID: 18988396)
-- Type: Monster / Effect / Ritual / Pendulum
-- Attribute: DARK
-- Race: Fiend
-- Level 1
-- ATK 300 | DEF 300
--
-- Effect Text:
-- ←0 【灵摆】 0→
-- 1回合1次，自己主要阶段：从自己的手卡·场上把等级合计直到1以上的怪兽解放，把这张卡仪式召唤。
-- 【怪兽效果】
-- 「奇迹的供物」降临。
-- 这张卡不用仪式召唤不能特殊召唤。
-- 仪式召唤的这张卡不受对方发动的效果影响。
-- 仪式怪兽1只仪式召唤的场合，可以用自己场上的这1张卡作为仪式召唤需要的数值的解放使用。
-- 这张卡为仪式召唤而解放的场合：可以从卡组把1只仪式怪兽加入手卡。「奇迹的供物」的这个效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--Miracle Raven
local s,id=GetID()
function s.initial_effect(c)
	c:EnableReviveLimit()
	aux.EnablePendulumAttribute(c)
	--spsummon limit
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetValue(aux.ritlimit)
	c:RegisterEffect(e0)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(s.pztg)
	e1:SetOperation(s.pzop)
	c:RegisterEffect(e1)
	--immune
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(s.ritcon)
	e2:SetValue(s.efilter)
	c:RegisterEffect(e2)
	--ritual level
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_RITUAL_LEVEL)
	e3:SetValue(s.rlevel)
	c:RegisterEffect(e3)
	--search
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(id,1))
	e4:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_RELEASE)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetCountLimit(1,id)
	e4:SetCondition(s.thcon)
	e4:SetTarget(s.thtg)
	e4:SetOperation(s.thop)
	c:RegisterEffect(e4)
end
function s.ritcon(e)
	local c=e:GetHandler()
	return c:IsSummonType(SUMMON_TYPE_RITUAL)
end
function s.efilter(e,te)
	return te:GetOwnerPlayer()~=e:GetHandlerPlayer() and te:IsActivated()
end
function s.rlevel(e,c)
	local ec=e:GetHandler()
	local lv=aux.GetCappedLevel(ec)
	if not ec:IsLocation(LOCATION_MZONE) then return lv end
	local clv=c:GetLevel()
	return (lv<<16)+clv
end
function s.thcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_RITUAL)~=0
end
function s.thfilter(c)
	return c:IsAllTypes(TYPE_RITUAL+TYPE_MONSTER) and c:IsAbleToHand()
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,s.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function s.pztg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then
		if not c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,false,true) then return false end
		local mg=Duel.GetRitualMaterial(tp)
		Auxiliary.GCheckAdditional=Auxiliary.RitualCheckAdditional(c,1,"Greater")
		local bool=mg:CheckSubGroup(Auxiliary.RitualCheck,1,1,tp,c,1,"Greater")
		Auxiliary.GCheckAdditional=nil
		return bool
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,tp,LOCATION_PZONE)
end
function s.pzop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,false,true) then return end
	local mg=Duel.GetRitualMaterial(tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	Auxiliary.GCheckAdditional=Auxiliary.RitualCheckAdditional(c,1,"Greater")
	local mat=mg:SelectSubGroup(tp,Auxiliary.RitualCheck,true,1,1,tp,c,1,"Greater")
	Auxiliary.GCheckAdditional=nil
	if mat and mat:GetCount()>0 then
		c:SetMaterial(mat)
		Duel.ReleaseRitualMaterial(mat)
		Duel.SpecialSummon(c,SUMMON_TYPE_RITUAL,tp,tp,false,true,POS_FACEUP)
		c:CompleteProcedure()
	end
end
