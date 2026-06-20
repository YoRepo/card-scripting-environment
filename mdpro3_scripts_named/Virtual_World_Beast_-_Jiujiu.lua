--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 电脑堺兽-鹫鹫  (ID: 35252119)
-- Type: Monster / Effect / Synchro
-- Attribute: WIND
-- Race: Psychic
-- Level 6
-- ATK 2400 | DEF 1700
-- Setcode: 334
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：只要原本的种族·属性相同而卡名不同的怪兽在自己墓地有2只以上存在，场上的这张卡不会被战斗·效果破坏。
-- ②：把原本的种族·属性相同而卡名不同的2只怪兽从自己墓地除外，以场上1张卡为对象才能发动。那张卡送去墓地。
--[[ __CARD_HEADER_END__ ]]

--電脳堺獣－鷲々
function c35252119.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	e1:SetCondition(c35252119.indcon)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e2)
	--to grave
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(35252119,0))
	e3:SetCategory(CATEGORY_TOGRAVE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,35252119)
	e3:SetCost(c35252119.tgcost)
	e3:SetTarget(c35252119.tgtg)
	e3:SetOperation(c35252119.tgop)
	c:RegisterEffect(e3)
end
function c35252119.indfilter(c,g)
	return g:IsExists(c35252119.indfilter2,1,c,c)
end
function c35252119.indfilter2(c,tc)
	return c:GetOriginalRace()&tc:GetOriginalRace()~=0
		and c:GetOriginalAttribute()&tc:GetOriginalAttribute()~=0
		and not c:IsCode(tc:GetCode())
end
function c35252119.indcon(e)
	local tp=e:GetHandlerPlayer()
	local g=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_GRAVE,0,nil,TYPE_MONSTER)
	return g:IsExists(c35252119.indfilter,1,nil,g)
end
function c35252119.fselect(g)
	return g:GetClassCount(Card.GetOriginalRace)==1
		and g:GetClassCount(Card.GetOriginalAttribute)==1
		and g:GetClassCount(Card.GetCode)>1
end
function c35252119.costfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c35252119.tgcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c35252119.costfilter,tp,LOCATION_GRAVE,0,nil)
	if chk==0 then return g:CheckSubGroup(c35252119.fselect,2,2) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local rg=g:SelectSubGroup(tp,c35252119.fselect,false,2,2)
	Duel.Remove(rg,POS_FACEUP,REASON_COST)
end
function c35252119.tgtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsAbleToGrave() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToGrave,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToGrave,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
end
function c35252119.tgop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoGrave(tc,REASON_EFFECT)
	end
end
