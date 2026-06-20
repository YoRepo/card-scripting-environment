--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 命运未来  (ID: 68663748)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：以除外的1只自己的「命运女郎」怪兽为对象才能发动。那只怪兽回到墓地。那之后，自己从卡组抽2张。
--[[ __CARD_HEADER_END__ ]]

--フォーチュンフューチャー
function c68663748.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c68663748.target)
	e1:SetOperation(c68663748.activate)
	c:RegisterEffect(e1)
end
function c68663748.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x31) and c:IsType(TYPE_MONSTER)
end
function c68663748.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(tp) and c68663748.filter(chkc) end
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2)
		and Duel.IsExistingTarget(c68663748.filter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(68663748,0))
	local g=Duel.SelectTarget(tp,c68663748.filter,tp,LOCATION_REMOVED,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c68663748.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoGrave(tc,REASON_EFFECT+REASON_RETURN)
		Duel.BreakEffect()
		Duel.Draw(tp,2,REASON_EFFECT)
	end
end
