--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 念力恶魔  (ID: 7582066)
-- Type: Monster / Effect / Synchro
-- Attribute: WIND
-- Race: Psychic
-- Level 6
-- ATK 2400 | DEF 1800
--
-- Effect Text:
-- 调整＋调整以外的念动力族怪兽1只以上
-- ①：1回合1次，自己主要阶段才能发动。对方手卡随机选1张，对那张卡的种类（怪兽·魔法·陷阱）作猜测。猜中的场合，这张卡的攻击力直到下次的对方回合的结束时上升1000。
--[[ __CARD_HEADER_END__ ]]

--サイコ・デビル
function c7582066.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsRace,RACE_PSYCHO),1)
	c:EnableReviveLimit()
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(7582066,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c7582066.atkcon)
	e1:SetOperation(c7582066.atkop)
	c:RegisterEffect(e1)
end
function c7582066.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)~=0
end
function c7582066.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() or Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)==0 then return end
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND):RandomSelect(tp,1)
	local tc=g:GetFirst()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CARDTYPE)
	local op=Duel.AnnounceType(tp)
	Duel.ConfirmCards(tp,tc)
	Duel.ShuffleHand(1-tp)
	if (op==0 and tc:IsType(TYPE_MONSTER)) or (op==1 and tc:IsType(TYPE_SPELL)) or (op==2 and tc:IsType(TYPE_TRAP)) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(1000)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END,2)
		c:RegisterEffect(e1)
	end
end
