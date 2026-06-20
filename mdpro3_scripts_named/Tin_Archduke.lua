--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 铁皮大公  (ID: 66506689)
-- Type: Monster / Effect / Xyz
-- Attribute: EARTH
-- Race: Machine
-- Rank 4
-- ATK 2200 | DEF 1200
--
-- Effect Text:
-- 4星怪兽×3
-- 1回合1次，把这张卡1个超量素材取除，选择对方场上1只怪兽才能发动。选择的怪兽的表示形式变更。这个时候，反转效果怪兽的效果不发动。这个效果在对方回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--ブリキの大公
function c66506689.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,3)
	c:EnableReviveLimit()
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(66506689,0))
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCountLimit(1)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c66506689.cost)
	e1:SetTarget(c66506689.tg)
	e1:SetOperation(c66506689.op)
	c:RegisterEffect(e1)
end
function c66506689.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c66506689.filter(c)
	return c:IsCanChangePosition()
end
function c66506689.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c66506689.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c66506689.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,c66506689.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c66506689.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK,true)
	end
end
