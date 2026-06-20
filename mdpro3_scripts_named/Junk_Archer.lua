--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 废品弓手  (ID: 42810973)
-- Type: Monster / Effect / Synchro
-- Attribute: EARTH
-- Race: Warrior
-- Level 7
-- ATK 2300 | DEF 2000
-- Setcode: 67
--
-- Effect Text:
-- 「废品同调士」＋调整以外的怪兽1只以上
-- 1回合1次，选择对方场上存在的1只怪兽才能发动。选择的怪兽从游戏中除外。这个效果除外的怪兽在这个回合的结束阶段时以相同表示形式回到对方场上。
--[[ __CARD_HEADER_END__ ]]

--ジャンク・アーチャー
function c42810973.initial_effect(c)
	aux.AddMaterialCodeList(c,63977008)
	--synchro summon
	aux.AddSynchroProcedure(c,c42810973.tfilter,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(42810973,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c42810973.target)
	e1:SetOperation(c42810973.operation)
	c:RegisterEffect(e1)
end
c42810973.material_setcode=0x1017
function c42810973.tfilter(c)
	return c:IsCode(63977008) or c:IsHasEffect(20932152)
end
function c42810973.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c42810973.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Remove(tc,0,REASON_EFFECT+REASON_TEMPORARY)~=0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		e1:SetLabelObject(tc)
		e1:SetOperation(c42810973.retop)
		Duel.RegisterEffect(e1,tp)
	end
end
function c42810973.retop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ReturnToField(e:GetLabelObject())
end
