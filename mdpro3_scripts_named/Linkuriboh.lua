--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 连接栗子球  (ID: 41999284)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Cyberse
-- ATK 300 | LINK
-- Setcode: 164
--
-- Effect Text:
-- 1星怪兽1只
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：对方怪兽的攻击宣言时，把这张卡解放才能发动。那只对方怪兽的攻击力直到回合结束时变成0。
-- ②：自己·对方回合，这张卡在墓地存在的场合，把自己场上1只1星怪兽解放才能发动。这张卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--リンクリボー
function c41999284.initial_effect(c)
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLevel,1),1)
	--atk to 0
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c41999284.atkcon)
	e1:SetCost(c41999284.atkcost)
	e1:SetOperation(c41999284.atkop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,41999284)
	e2:SetHintTiming(0,TIMING_BATTLE_START)
	e2:SetCost(c41999284.spcost)
	e2:SetTarget(c41999284.sptg)
	e2:SetOperation(c41999284.spop)
	c:RegisterEffect(e2)
end
function c41999284.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and aux.nzatk(Duel.GetAttacker())
end
function c41999284.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c41999284.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc:IsRelateToBattle() and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c41999284.cfilter(c,tp)
	return c:IsLevel(1) and Duel.GetMZoneCount(tp,c)>0
end
function c41999284.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c41999284.cfilter,1,nil,tp) end
	local g=Duel.SelectReleaseGroup(tp,c41999284.cfilter,1,1,nil,tp)
	Duel.Release(g,REASON_COST)
end
function c41999284.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c41999284.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
