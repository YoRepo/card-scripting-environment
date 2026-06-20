--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: No.103 神葬零娘 暮零  (ID: 94380860)
-- Type: Monster / Effect / Xyz
-- Attribute: WATER
-- Race: Fairy
-- Rank 4
-- ATK 2400 | DEF 1200
-- Setcode: 72
--
-- Effect Text:
-- 4星怪兽×2
-- ①：自己·对方回合1次，把这张卡1个超量素材取除，以持有和原本攻击力不同攻击力的对方场上1只攻击表示怪兽为对象才能发动。那只怪兽破坏，自己抽1张。
--[[ __CARD_HEADER_END__ ]]

--No.103 神葬零嬢ラグナ・ゼロ
function c94380860.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,2)
	c:EnableReviveLimit()
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(94380860,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c94380860.cost)
	e1:SetTarget(c94380860.target)
	e1:SetOperation(c94380860.operation)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	c:RegisterEffect(e1)
end
aux.xyz_number[94380860]=103
function c94380860.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c94380860.filter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and not c:IsAttack(c:GetBaseAttack())
end
function c94380860.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c94380860.filter(chkc) end
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1)
		and Duel.IsExistingTarget(c94380860.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c94380860.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c94380860.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.Destroy(tc,REASON_EFFECT)~=0 then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
