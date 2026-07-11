--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Mysterion the Dragon Crown  (ID: 13735899)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level: 8
-- ATK 3000 | DEF 1500
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Spellcaster monster + 1 Dragon monster
-- Cannot be used as Fusion Material.
-- Loses 100 ATK for each of your banished cards.
-- If a monster uses its activated effect to Special Summon itself, or a monster(s) with its same
-- original Type (except during the Damage Step): You can target 1 of those Special Summoned monsters;
-- banish that monster, also banish all monsters from the field with its same original Type.
-- You can only use this effect of "Mysterion the Dragon Crown" once per turn.
--[[ __CARD_HEADER_END__ ]]

--ミュステリオンの竜冠
function c13735899.initial_effect(c)
	--fusion summon
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsRace,RACE_SPELLCASTER),aux.FilterBoolFunction(Card.IsRace,RACE_DRAGON),true)
	--cannot be fusion material
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--ATK down
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetValue(c13735899.atkval)
	c:RegisterEffect(e2)
	--remove
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(13735899,0))
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,13735899)
	e3:SetCondition(c13735899.remcon)
	e3:SetTarget(c13735899.remtg)
	e3:SetOperation(c13735899.remop)
	c:RegisterEffect(e3)
end
function c13735899.atkval(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_REMOVED,0)*-100
end
function c13735899.cfilter(c,e)
	local typ,se=c:GetSpecialSummonInfo(SUMMON_INFO_TYPE,SUMMON_INFO_REASON_EFFECT)
	if not se then return false end
	local sc=se:GetHandler()
	local tp=e:GetHandlerPlayer()
	return typ&TYPE_MONSTER~=0 and se:IsActivated()
		and c:IsFaceup() and (c:GetOriginalRace()==sc:GetOriginalRace() or c==sc)
		and c:IsCanBeEffectTarget(e) and Duel.IsExistingMatchingCard(c13735899.rmfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,c)
end
function c13735899.remcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c13735899.cfilter,1,nil,e)
		and not eg:IsContains(e:GetHandler())
end
function c13735899.rmfilter(c,tc)
	return c:IsFaceup() and c:GetOriginalRace()==tc:GetOriginalRace() and c:IsAbleToRemove()
end
function c13735899.remtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local g=eg:Filter(c13735899.cfilter,nil,e):Filter(Card.IsLocation,nil,LOCATION_MZONE)
	if chkc then return aux.IsInGroup(chkc,g) end
	if chk==0 then return Duel.IsExistingTarget(aux.IsInGroup,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,g) end
	local tc=g:GetFirst()
	if #g>1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		tc=g:Select(tp,1,1,nil):GetFirst()
	end
	Duel.SetTargetCard(tc)
	local tg=Duel.GetMatchingGroup(c13735899.rmfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,tc)
	tg:AddCard(tc)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,tg,#tg,0,0)
end
function c13735899.remop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local g=Group.FromCards(tc)
		if tc:IsFaceup() then
			g=g+Duel.GetMatchingGroup(c13735899.rmfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,tc)
		end
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	end
end
