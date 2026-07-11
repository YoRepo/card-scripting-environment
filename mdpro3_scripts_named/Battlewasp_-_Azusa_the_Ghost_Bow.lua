--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Battlewasp - Azusa the Ghost Bow  (ID: 27565379)
-- Type: Monster / Effect / Tuner / Synchro
-- Attribute: WIND
-- Race: Insect
-- Level: 5
-- ATK 2200 | DEF 1600
-- Setcode: 0x12f
-- Scope: OCG / TCG
--
-- Effect Text:
-- 1 Tuner + 1+ non-Tuner monsters
-- When your opponent takes effect damage from another "Battlewasp" monster: You can inflict damage to
-- your opponent equal to the original ATK of that monster.
-- You can only use this effect of "Battlewasp - Azusa the Ghost Bow" once per turn.
-- When a monster is destroyed by battle with your "Battlewasp" monster, while this card is in your GY:
-- You can Special Summon this card in Defense Position, but banish it when it leaves the field.
--[[ __CARD_HEADER_END__ ]]

--B・F－霊弓のアズサ
function c27565379.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--Damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(27565379,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCode(EVENT_DAMAGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,27565379)
	e1:SetCondition(c27565379.damcon)
	e1:SetTarget(c27565379.damtg)
	e1:SetOperation(c27565379.damop)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(27565379,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCondition(c27565379.spcon)
	e2:SetTarget(c27565379.sptg)
	e2:SetOperation(c27565379.spop)
	c:RegisterEffect(e2)
end
function c27565379.damcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and bit.band(r,REASON_BATTLE)==0 and re and re:GetHandler()~=e:GetHandler() and re:IsActiveType(TYPE_MONSTER) and re:GetHandler():IsSetCard(0x12f)
end
function c27565379.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local tc=re:GetHandler()
	local atk=tc:GetBaseAttack()
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,atk)
end
function c27565379.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local tc=re:GetHandler()
	local atk=tc:GetBaseAttack()
	Duel.Damage(p,atk,REASON_EFFECT)
end
function c27565379.cfilter(c,tp)
	if c:IsSetCard(0x12f) and c:IsPreviousControler(tp) then return true end
	local rc=c:GetBattleTarget()
	return rc:IsSetCard(0x12f)
		and (not rc:IsLocation(LOCATION_MZONE) and rc:IsPreviousControler(tp)
			or rc:IsLocation(LOCATION_MZONE) and rc:IsControler(tp))
end
function c27565379.spcon(e,tp,eg,ep,ev,re,r,rp)
	return not eg:IsContains(e:GetHandler()) and eg:IsExists(c27565379.cfilter,1,nil,tp)
end
function c27565379.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c27565379.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_DEFENSE)~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
		e1:SetValue(LOCATION_REMOVED)
		c:RegisterEffect(e1,true)
	end
end
