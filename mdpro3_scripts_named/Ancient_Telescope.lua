--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 古代的望远镜  (ID: 17092736)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 查看对方卡组最上面的最多5张卡，然后放回原处。
--[[ __CARD_HEADER_END__ ]]

--古代の遠眼鏡
function c17092736.initial_effect(c)
	--confirm
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c17092736.cftg)
	e1:SetOperation(c17092736.cfop)
	c:RegisterEffect(e1)
end
function c17092736.cftg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>0 end
	Duel.SetTargetPlayer(tp)
end
function c17092736.cfop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local ct=math.min(5,Duel.GetFieldGroupCount(p,0,LOCATION_DECK))
	local t={}
	for i=1,ct do
		t[i]=i
	end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(17092736,0))
	local ac=Duel.AnnounceNumber(p,table.unpack(t))
	local g=Duel.GetDecktopGroup(1-p,ac)
	if g:GetCount()>0 then
		Duel.ConfirmCards(p,g)
	end
end
