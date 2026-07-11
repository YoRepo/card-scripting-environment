--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Red-Eyes Burn  (ID: 71782404)
-- Type: Trap
-- Setcode: 0x3b
-- Scope: OCG / TCG
--
-- Effect Text:
-- If a face-up "Red-Eyes" monster(s) you control is destroyed by battle or card effect: Target 1 of
-- those monsters; both players take damage equal to its original ATK.
-- You can only activate 1 "Red-Eyes Burn" per turn.
--[[ __CARD_HEADER_END__ ]]

--レッドアイズ・バーン
function c71782404.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCountLimit(1,71782404+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c71782404.target)
	e1:SetOperation(c71782404.activate)
	c:RegisterEffect(e1)
end
function c71782404.cfilter(c,e,tp)
	return c:IsPreviousPosition(POS_FACEUP) and c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_MZONE) and c:IsReason(REASON_EFFECT+REASON_BATTLE)
		and c:IsPreviousSetCard(0x3b) and c:GetBaseAttack()>0 and c:IsCanBeEffectTarget(e) and c:IsLocation(LOCATION_GRAVE+LOCATION_REMOVED)
end
function c71782404.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return eg:IsContains(chkc) and c71782404.cfilter(chkc,e,tp) end
	if chk==0 then return eg:IsExists(c71782404.cfilter,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=eg:FilterSelect(tp,c71782404.cfilter,1,1,nil,e,tp)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,g:GetFirst():GetBaseAttack())
end
function c71782404.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Damage(1-tp,tc:GetBaseAttack(),REASON_EFFECT,true)
		Duel.Damage(tp,tc:GetBaseAttack(),REASON_EFFECT,true)
		Duel.RDComplete()
	end
end
