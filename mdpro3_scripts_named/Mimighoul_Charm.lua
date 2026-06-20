--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 迷拟宝箱鬼·魅惑  (ID: 55733143)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 439
--
-- Effect Text:
-- 这个卡名的①的效果1回合可以使用最多2次。
-- ①：对方场上的「迷拟宝箱鬼」怪兽在主要阶段反转的场合才能发动（同一连锁上最多1次）。对方的额外卡组的里侧的卡随机选1张。那张卡是可以特殊召唤的怪兽的场合，那只怪兽在自己场上特殊召唤。不是的场合或者不能
-- 特殊召唤的场合，那张卡除外。这个效果特殊召唤的怪兽在这个回合不能把效果发动。
--[[ __CARD_HEADER_END__ ]]

--ミミグル・チャーム
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--SpecialSummon&Remove
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_CHANGE_POS)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCountLimit(2,id)
	e2:SetCondition(s.spcon)
	e2:SetTarget(s.sptg)
	e2:SetOperation(s.spop)
	c:RegisterEffect(e2)
end
function s.cfilter2(c,tp)
	return c:IsPreviousPosition(POS_FACEDOWN) and c:IsFaceup() and c:IsControler(1-tp) and c:IsSetCard(0x1b7)
end
function s.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.cfilter2,1,nil,tp) and (Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2)
end
function s.spfilter(c)
	return c:IsFacedown() and c:IsAbleToRemove()
end
function s.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.spfilter,tp,0,LOCATION_EXTRA,1,nil) and e:GetHandler():GetFlagEffect(id)==0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
	e:GetHandler():RegisterFlagEffect(id,RESET_CHAIN,0,1)
end
function s.spop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFacedown,tp,0,LOCATION_EXTRA,nil)
	if #g==0 then return end
	Duel.ShuffleExtra(1-tp)
	local tg=g:RandomSelect(1-tp,1)
	Duel.ConfirmCards(tp,tg)
	local tc=tg:GetFirst()
	if tc:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,nil,tc)>0 and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)~=0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_TRIGGER)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	else
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
