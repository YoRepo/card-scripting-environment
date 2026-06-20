--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 禁断的异本  (ID: 3211439)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：宣言1个怪兽卡的种类（融合·同调·超量）才能发动。宣言的种类的怪兽在场上有2只以上表侧表示存在的场合，双方玩家必须把场上的那个种类的怪兽全部送去墓地。
--[[ __CARD_HEADER_END__ ]]

--禁断の異本
function c3211439.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c3211439.target)
	e1:SetOperation(c3211439.activate)
	c:RegisterEffect(e1)
end
function c3211439.filter(c,tpe)
	return c:IsFaceup() and c:IsType(tpe)
end
function c3211439.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local b1=Duel.IsExistingMatchingCard(c3211439.filter,tp,LOCATION_MZONE,LOCATION_MZONE,2,nil,TYPE_FUSION)
	local b2=Duel.IsExistingMatchingCard(c3211439.filter,tp,LOCATION_MZONE,LOCATION_MZONE,2,nil,TYPE_SYNCHRO)
	local b3=Duel.IsExistingMatchingCard(c3211439.filter,tp,LOCATION_MZONE,LOCATION_MZONE,2,nil,TYPE_XYZ)
	if chk==0 then return b1 or b2 or b3 end
	local off=1
	local ops={}
	local opval={}
	if b1 then
		ops[off]=aux.Stringid(3211439,0)
		opval[off-1]=TYPE_FUSION
		off=off+1
	end
	if b2 then
		ops[off]=aux.Stringid(3211439,1)
		opval[off-1]=TYPE_SYNCHRO
		off=off+1
	end
	if b3 then
		ops[off]=aux.Stringid(3211439,2)
		opval[off-1]=TYPE_XYZ
		off=off+1
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CARDTYPE)
	local op=Duel.SelectOption(tp,table.unpack(ops))
	e:SetLabel(opval[op])
end
function c3211439.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c3211439.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,e:GetLabel())
	if g:GetCount()>1 then
		Duel.SendtoGrave(g,REASON_RULE)
	end
end
