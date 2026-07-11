--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Dimension Slice  (ID: 73632127)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- When a monster(s) is Special Summoned to your side of the field (except during the Damage Step):
-- Target 1 face-up monster your opponent controls; banish that target.
-- If the Summon is an Xyz Summon, you can activate this card the turn it was Set.
--[[ __CARD_HEADER_END__ ]]

--ディメンション・スライド
function c73632127.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c73632127.condition)
	e1:SetTarget(c73632127.target)
	e1:SetOperation(c73632127.activate)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(73632127,0))
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRAP_ACT_IN_SET_TURN)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e2:SetCondition(c73632127.actcon)
	c:RegisterEffect(e2)
end
function c73632127.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsControler,1,nil,tp)
end
function c73632127.filter(c)
	return c:IsFaceup() and c:IsAbleToRemove()
end
function c73632127.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c73632127.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c73632127.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c73632127.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c73632127.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
function c73632127.actcon(e)
	local res,teg,tep,tev,tre,tr,trp=Duel.CheckEvent(EVENT_SPSUMMON_SUCCESS,true)
	if res then
		return teg:GetCount()==1 and teg:GetFirst():IsSummonType(SUMMON_TYPE_XYZ)
	end
end
