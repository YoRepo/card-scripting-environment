--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 极光之天气模样  (ID: 52834429)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
-- Setcode: 265
--
-- Effect Text:
-- ①：「极光之天气模样」在自己场上只能有1张表侧表示存在。
-- ②：和这张卡相同纵列的自己的主要怪兽区域以及那些两邻的自己的主要怪兽区域存在的「天气」效果怪兽得到以下效果。
-- ●只让卡1张加入自己或者对方的手卡时，把这张卡除外才能发动。加入手卡的那张卡除外，那个玩家从卡组抽1张。
--[[ __CARD_HEADER_END__ ]]

--オーロラの天気模様
function c52834429.initial_effect(c)
	c:SetUniqueOnField(1,0,52834429)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--effect gain
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(52834429,0))
	e2:SetCategory(CATEGORY_REMOVE+CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_HAND)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c52834429.rmcon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c52834429.rmtg)
	e2:SetOperation(c52834429.rmop)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(c52834429.eftg)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
end
function c52834429.eftg(e,c)
	local seq=c:GetSequence()
	return c:IsType(TYPE_EFFECT) and c:IsSetCard(0x109)
		and seq<5 and math.abs(e:GetHandler():GetSequence()-seq)<=1
end
function c52834429.rmcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:GetCount()==1
end
function c52834429.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local ec=eg:GetFirst()
	if chk==0 then return ec and ec:IsAbleToRemove() and Duel.IsPlayerCanDraw(ec:GetControler(),1) end
	local p=ec:GetControler()
	Duel.SetTargetPlayer(p)
	Duel.SetTargetParam(1)
	e:SetLabelObject(ec)
	ec:CreateEffectRelation(e)
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,ec,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,p,1)
end
function c52834429.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if not tc or not tc:IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)>0 then
		Duel.Draw(p,d,REASON_EFFECT)
	end
end
