--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 工具起子  (ID: 54497620)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 1
-- ATK 200 | DEF 200
-- Setcode: 81
--
-- Effect Text:
-- ①：把这张卡从手卡送去墓地，以自己场上的「变形斗士」怪兽任意数量为对象才能发动。那些自己的「变形斗士」怪兽的表示形式变更。这个效果在对方回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--ガジェット・ドライバー
function c54497620.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(54497620,0))
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c54497620.cost)
	e1:SetTarget(c54497620.tg)
	e1:SetOperation(c54497620.op)
	c:RegisterEffect(e1)
end
function c54497620.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c54497620.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x26)
end
function c54497620.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c54497620.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c54497620.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,c54497620.filter,tp,LOCATION_MZONE,0,1,7,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c54497620.tfilter(c,e)
	return c:IsRelateToEffect(e) and c:IsFaceup()
end
function c54497620.op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(c54497620.tfilter,nil,e)
	Duel.ChangePosition(sg,POS_FACEUP_DEFENSE,0,POS_FACEUP_ATTACK,0)
end
